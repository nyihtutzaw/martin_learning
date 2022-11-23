import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optimize/constants/chat_api.dart';
import 'package:optimize/screens/preview_image.dart';
import 'package:optimize/widgets/full_screen_preloader.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../../providers/message_provider.dart';
import '../../controllers/chat_controller.dart';
import '../../models/message_model.dart';
import '../../widgets/single_view_image.dart';
import '../constants/active_constants.dart';
import '../providers/auth_provider.dart';
import '../widgets/minor_app_bar.dart';
import '../widgets/my_drawer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  String message = '';

  late io.Socket socket;
  ChatController chatController = ChatController();

  bool _isInit = false;
  bool _isLoading = false;

  Future<void> loadData() async {
    setState(() {
      _isLoading = true;
    });

    final Auth auth = Provider.of<Auth>(context, listen: false);
    await auth.getUser();

    if (!mounted) return;
    final MessageProvider messageProvider =
        Provider.of<MessageProvider>(context, listen: false);
    String chatId = adminID.toString() + auth.currentUser.id.toString();
    await messageProvider.list(chatId);
    chatController.messages.addAll(messageProvider.messages);

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> pickImage() async {
    final Auth auth = Provider.of<Auth>(context, listen: false);
    String chatId = adminID.toString() + auth.currentUser.id.toString();
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    if (!mounted) return;
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => PreviewImageScreen(
          path: image.path,
          socket: socket,
          chatController: chatController,
          chatId: chatId,
          senderId: auth.currentUser.id,
          receiverId: adminID,
        ),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      loadData();
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    socket = io.io(
        path,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
    showMessage();
    userConnected();
    super.initState();
  }

  void userConnected() {
    final Auth auth = Provider.of<Auth>(context, listen: false);
    socket.emit('user_connected', auth.currentUser.id);
  }

  void showMessage() {
    socket.on('message-receive', (data) {
      chatController.messages.insert(0, MessageModel.fromJson(data));
    });
  }

  void sendMessage() {
    final Auth auth = Provider.of<Auth>(context, listen: false);
    String chatId = adminID.toString() + auth.currentUser.id.toString();

    Map<String, dynamic> message = {
      "chatId": chatId,
      "senderId": auth.currentUser.id,
      "receiverId": adminID,
      "message": _messageController.text,
      "media": '',
    };
    socket.emit('message', message);

    chatController.messages.insert(
      0,
      MessageModel(
        chatId: message['chatId'],
        senderId: message['senderId'],
        receiverId: message['receiverId'],
        message: message['message'],
        media: message['media'],
      ),
    );
    _messageController.clear();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      appBar: const MinorAppBar(title: 'Chat'),
      drawer: const MyDrawer(),
      body: _isLoading
          ? FullScreenPreloader()
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                MessageStream(
                  chatController: chatController,
                  senderId: auth.currentUser.id,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          color: activeColors.secondary.withOpacity(0.2),
                          width: 2.0),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          onChanged: (String value) {
                            setState(() {
                              message = value;
                            });
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20.0,
                            ),
                            hintText: 'Type your message here...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        iconSize: 25.0,
                        color: activeColors.secondary,
                        icon: const Icon(Icons.upload_rounded),
                        onPressed: pickImage,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: activeColors.primary,
                          minimumSize: const Size(40, 40),
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.zero,
                              bottomRight: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0),
                            ),
                          ),
                        ),
                        onPressed:
                            _messageController.text == '' ? null : sendMessage,
                        child: const Icon(
                          Icons.send,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class MessageStream extends StatelessWidget {
  final ChatController chatController;
  final int senderId;
  const MessageStream({
    Key? key,
    required this.chatController,
    required this.senderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          reverse: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 3,
          ),
          itemCount: chatController.messages.length,
          itemBuilder: (BuildContext context, index) {
            MessageModel message = chatController.messages[index];

            return MessageBubble(
              text: message.message,
              media: message.media,
              isMe: message.senderId == senderId,
              onDismissed: (direction) {},
            );
          },
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String media;
  final void Function(DismissDirection)? onDismissed;

  const MessageBubble({
    Key? key,
    required this.text,
    required this.isMe,
    required this.media,
    required this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: isMe ? onDismissed : null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Material(
              elevation: 5.0,
              color: isMe ? activeColors.primary : activeColors.secondary,
              borderRadius: isMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: SizedBox(
                  width: media != '' ? 150.0 : 130,
                  child: Column(
                    children: [
                      media != '' ? GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) {
                                return SingleViewImage(
                                    image: '$path/api/messages/view/$media');
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: 150.0,
                          height: 200.0,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.zero,
                              bottomLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                '$path/api/messages/view/$media',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ) : Container(),
                      Center(
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: isMe ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final void Function(DismissDirection)? onDismissed;

  const ImageBubble({
    Key? key,
    required this.text,
    required this.isMe,
    required this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: isMe ? onDismissed : null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Material(
              elevation: 5.0,
              borderRadius: isMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) {
                          return SingleViewImage(
                              image: '$path/api/messages/$text');
                        },
                      ),
                    );
                  },
                  child: Container(
                    width: 150.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.zero,
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          '$path/api/messages/view/$text',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
