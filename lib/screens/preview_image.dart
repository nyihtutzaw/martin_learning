import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:optimize/widgets/full_screen_preloader.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../constants/active_constants.dart';
import '../controllers/chat_controller.dart';
import '../models/message_model.dart';
import '../providers/message_provider.dart';
import '../utils/toast.dart';

class PreviewImageScreen extends StatefulWidget {
  final String path;
  final io.Socket socket;
  final ChatController chatController;
  final String chatId;
  final int senderId;
  final int receiverId;
  const PreviewImageScreen({
    Key? key,
    required this.path,
    required this.socket,
    required this.chatController,
    required this.chatId,
    required this.senderId,
    required this.receiverId,
  }) : super(key: key);

  @override
  State<PreviewImageScreen> createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  bool _isLoading = false;

  void sendImage(String filename) {
    Map<String, dynamic> message = {
      "chatId": widget.chatId,
      "senderId": widget.senderId,
      "receiverId": widget.receiverId,
      "message": '',
      "media": filename,
    };
    widget.socket.emit('message', message);

    widget.chatController.messages.insert(
      0,
      MessageModel(
        chatId: message['chatId'],
        senderId: message['senderId'],
        receiverId: message['receiverId'],
        message: message['message'],
        media: message['media'],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final MessageProvider messageProvider =
    Provider.of<MessageProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: _isLoading ? FullScreenPreloader() : Stack(
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
              child: Image.file(
                File(widget.path),
                height: size.height,
                width: size.width,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: 0.0,
              child: Material(
                color: Colors.white,
                elevation: 0,
                child: SizedBox(
                  width: size.width,
                  child: Row(
                    children: [
                      IconButton(
                        color: Colors.black,
                        iconSize: size.height * 0.03,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: activeColors.primary,
        onPressed: () async {
          FormData formData = FormData.fromMap({
            'file': await MultipartFile.fromFile(widget.path),
          });
          setState(() {
            _isLoading = true;
          });
          await messageProvider.create(formData);
          setState(() {
            _isLoading = false;
          });
          if (messageProvider.errorMessage != null) {
            if (!mounted) return;
            showToast(context, messageProvider.errorMessage ?? '');
          } else {
            sendImage(messageProvider.fileName!);
            if (!mounted) return;
            Navigator.pop(context);
          }
        },
        child: const Icon(Icons.send),
      ),
    );
  }
}
