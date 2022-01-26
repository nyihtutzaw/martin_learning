import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:optimize/models/OneZOne.dart';
import 'package:optimize/providers/one_z_one_provider.dart';
import 'package:optimize/screens/pdf_list_screen.dart';
import 'package:optimize/screens/pdf_viewer.dart';
import 'package:optimize/screens/photo_view_screen.dart';
import 'package:optimize/screens/video_list_screen.dart';
import 'package:optimize/screens/video_view_screen.dart';
import 'package:optimize/widgets/full_screen_preloader.dart';
import 'package:optimize/widgets/home_app_bar.dart';
import 'package:optimize/widgets/message_dialog.dart';
import 'package:optimize/widgets/premium_message.dart';
import 'package:provider/provider.dart';
import '../constants/active_constants.dart';
import 'audio_list_screen.dart';
import 'music_player_screen.dart';

class OneZOneDetailScreen extends StatefulWidget {
  final OneZOne data;
  const OneZOneDetailScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<OneZOneDetailScreen> createState() => _OneZOneDetailScreenState();
}

class _OneZOneDetailScreenState extends State<OneZOneDetailScreen> {
  bool _isInit = false;
  bool _isPreloading = false;

  void loadData() async {
    setState(() {
      _isPreloading = true;
    });
    try {
      await Provider.of<OneZOneProvider>(context, listen: false)
          .getEach(widget.data.id);
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        _isPreloading = false;
      });
    }
  }

  void didChangeDependencies() {
    if (!_isInit) {
      loadData();
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  Future<void> onSubscribe() async {
    await Provider.of<OneZOneProvider>(context, listen: false)
        .subscribeCourse(widget.data.id);
    MessageDialog.show(
        context,
        "You have subcribed successfully. Please wait for admin confirmiation",
        "Success",
        "Close");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: activeColors.primary,
          title: Text("Course: " + widget.data.title.toString()),
          centerTitle: false,
          titleSpacing: 0.0,
          titleTextStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: SingleChildScrollView(
            child: _isPreloading
                ? FullScreenPreloader()
                : Consumer<OneZOneProvider>(
                    builder: (context, appState, child) {
                    return Container(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoViewScreen(
                                    url: appState.item.video,
                                    isUbube: appState.item.isUtube,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: 180,
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image: NetworkImage(appState.item.thumbnail),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: activeIcons.playerCircleFill,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.1),
                            child: Column(
                              children: [
                                Text(appState.item.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    )),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  appState.item.subtitle,
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    appState.item.isLiked
                                        ? GestureDetector(
                                            onTap: () async {
                                              await Provider.of<
                                                          OneZOneProvider>(
                                                      context,
                                                      listen: false)
                                                  .markData("like",
                                                      appState.item.id, 0);
                                            },
                                            child: activeIcons.heartCircleFill)
                                        : GestureDetector(
                                            onTap: () async {
                                              await Provider.of<
                                                          OneZOneProvider>(
                                                      context,
                                                      listen: false)
                                                  .markData("like",
                                                      appState.item.id, 1);
                                            },
                                            child: activeIcons.heartCircle),
                                    const SizedBox(width: 10.0),
                                    appState.item.isTipped
                                        ? GestureDetector(
                                            onTap: () async {
                                              await Provider.of<
                                                          OneZOneProvider>(
                                                      context,
                                                      listen: false)
                                                  .markData("tip",
                                                      appState.item.id, 0);
                                            },
                                            child: activeIcons.checkCircleFill)
                                        : GestureDetector(
                                            onTap: () async {
                                              await Provider.of<
                                                          OneZOneProvider>(
                                                      context,
                                                      listen: false)
                                                  .markData("tip",
                                                      appState.item.id, 1);
                                            },
                                            child: activeIcons.checkCircle),
                                    const SizedBox(width: 10.0),
                                    appState.item.isBooked
                                        ? GestureDetector(
                                            onTap: () async {
                                              await Provider.of<
                                                          OneZOneProvider>(
                                                      context,
                                                      listen: false)
                                                  .markData("bookmark",
                                                      appState.item.id, 0);
                                            },
                                            child: activeIcons.saveCircleFill)
                                        : GestureDetector(
                                            onTap: () async {
                                              await Provider.of<
                                                          OneZOneProvider>(
                                                      context,
                                                      listen: false)
                                                  .markData("bookmark",
                                                      appState.item.id, 1);
                                            },
                                            child: activeIcons.saveCircle),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.withOpacity(0.1),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                                EdgeInsets>(
                                            EdgeInsets.symmetric(vertical: 5)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blue),
                                      ),
                                      onPressed: () {
                                        if (appState.item.isSub) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AudioListScreen(
                                                      type: "101",
                                                      cover: appState
                                                          .item.thumbnail,
                                                      subTitle:
                                                          appState.item.title,
                                                      files: appState
                                                          .item.audioFiles,
                                                    )),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PremiumMessage(
                                                        onClick: onSubscribe,
                                                        type: "101",
                                                        id: appState.item.id)),
                                          );
                                        }
                                      },
                                      child: Column(
                                        children: [
                                          const Icon(Icons.music_note),
                                          Text(
                                            "Listen",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                                EdgeInsets>(
                                            EdgeInsets.symmetric(vertical: 5)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blue),
                                      ),
                                      onPressed: () {
                                        if (appState.item.isSub) {
                                          if (widget.data.poster_image.length >
                                              0) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PhotoViewScreen(
                                                        image: widget
                                                            .data.poster_image),
                                              ),
                                            );
                                          }
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PremiumMessage(
                                                        onClick: onSubscribe,
                                                        type: "101",
                                                        id: appState.item.id)),
                                          );
                                        }
                                      },
                                      child: Column(
                                        children: [
                                          const Icon(Icons.book),
                                          Text(
                                            "Poster",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                                EdgeInsets>(
                                            EdgeInsets.symmetric(vertical: 5)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blue),
                                      ),
                                      onPressed: () {
                                        if (appState.item.isSub) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PdfListScreen(
                                                type: "101",
                                                files: appState.item.pdfFiles,
                                              ),
                                            ),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PremiumMessage(
                                                        onClick: onSubscribe,
                                                        type: "101",
                                                        id: appState.item.id)),
                                          );
                                        }
                                      },
                                      child: Column(
                                        children: [
                                          const Icon(Icons.document_scanner),
                                          Text(
                                            "Workbook",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                                EdgeInsets>(
                                            EdgeInsets.symmetric(vertical: 5)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blue),
                                      ),
                                      onPressed: () {
                                        if (appState.item.isSub) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  VideoListScreen(
                                                type: "101",
                                                files: appState.item.videoFiles,
                                              ),
                                            ),
                                          );
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PremiumMessage(
                                                        onClick: onSubscribe,
                                                        type: "101",
                                                        id: appState.item.id)),
                                          );
                                        }
                                      },
                                      child: Column(
                                        children: [
                                          const Icon(Icons.tv),
                                          Text(
                                            "Videos",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.1),
                            child: Html(
                              data: appState.item.description,
                            ),
                          ),
                        ],
                      ),
                    );
                  })));
  }
}
