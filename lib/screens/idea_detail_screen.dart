import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:optimize/models/OneZOne.dart';
import 'package:optimize/providers/idea_provider.dart';
import 'package:optimize/providers/one_z_one_provider.dart';
import 'package:optimize/screens/pdf_list_screen.dart';
import 'package:optimize/screens/poster_list_screen.dart';
import 'package:optimize/screens/video_list_screen.dart';
import 'package:optimize/screens/video_view_screen.dart';
import 'package:optimize/widgets/full_screen_preloader.dart';
import 'package:optimize/widgets/message_dialog.dart';
import 'package:optimize/widgets/premium_message.dart';
import 'package:provider/provider.dart';
import '../constants/active_constants.dart';
import '../models/Idea.dart';
import 'audio_list_screen.dart';

class IdeaDetailScreen extends StatefulWidget {
  final Idea data;
  const IdeaDetailScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<IdeaDetailScreen> createState() => _IdeaDetailScreenState();
}

class _IdeaDetailScreenState extends State<IdeaDetailScreen> {
  bool _isInit = false;
  bool _isPreloading = false;

  void loadData() async {
    setState(() {
      _isPreloading = true;
    });
    try {
      await Provider.of<IdeaProvider>(context, listen: false)
          .getEach(widget.data.id);
    } catch (error) {
      print(error);
    } finally {
      print("finally");
      setState(() {
        _isPreloading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      loadData();
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  Future<void> onSubscribe() async {
   
    MessageDialog.show(
        context,
        "admin မှ လက်ခံပေးပါမယ် ခဏစောင့်ပြီး ပြန်ဝင်ကြည့်ပါ",
        "Success",
        "Close");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: activeColors.primary,
        title: Text("Course: ${widget.data.title}"),
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
            : Consumer<IdeaProvider>(
                builder: (context, appState, child) {
                  return Container(
                    child: Column(
                      children: [
                        // video thumbnail
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
                        // Container(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal:
                        //           MediaQuery.of(context).size.width * 0.1),
                        //   child: Column(
                        //     children: [
                        //       Text(appState.item.title,
                        //           style: const TextStyle(
                        //             fontSize: 18,
                        //             color: Colors.black,
                        //             fontWeight: FontWeight.w600,
                        //           )),
                        //       const SizedBox(
                        //         height: 5,
                        //       ),
                        //       Text(
                        //         appState.item.subtitle,
                        //         style: const TextStyle(
                        //           fontSize: 13,
                        //         ),
                        //         textAlign: TextAlign.center,
                        //       ),
                        //       const SizedBox(
                        //         height: 10,
                        //       ),
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           appState.item.isLiked
                        //               ? GestureDetector(
                        //                   onTap: () async {
                        //                     await Provider.of<IdeaProvider>(
                        //                             context,
                        //                             listen: false)
                        //                         .markData("like",
                        //                             appState.item.id, 0);
                        //                   },
                        //                   child: activeIcons.heartCircleFill)
                        //               : GestureDetector(
                        //                   onTap: () async {
                        //                     await Provider.of<IdeaProvider>(
                        //                             context,
                        //                             listen: false)
                        //                         .markData("like",
                        //                             appState.item.id, 1);
                        //                   },
                        //                   child: activeIcons.heartCircle),
                        //           const SizedBox(width: 10.0),
                        //           appState.item.isTipped
                        //               ? GestureDetector(
                        //                   onTap: () async {
                        //                     await Provider.of<IdeaProvider>(
                        //                             context,
                        //                             listen: false)
                        //                         .markData(
                        //                             "tip", appState.item.id, 0);
                        //                   },
                        //                   child: activeIcons.checkCircleFill)
                        //               : GestureDetector(
                        //                   onTap: () async {
                        //                     await Provider.of<IdeaProvider>(
                        //                             context,
                        //                             listen: false)
                        //                         .markData(
                        //                             "tip", appState.item.id, 1);
                        //                   },
                        //                   child: activeIcons.checkCircle),
                        //           const SizedBox(width: 10.0),
                        //           appState.item.isBooked
                        //               ? GestureDetector(
                        //                   onTap: () async {
                        //                     await Provider.of<IdeaProvider>(
                        //                             context,
                        //                             listen: false)
                        //                         .markData("bookmark",
                        //                             appState.item.id, 0);
                        //                   },
                        //                   child: activeIcons.saveCircleFill)
                        //               : GestureDetector(
                        //                   onTap: () async {
                        //                     await Provider.of<IdeaProvider>(
                        //                             context,
                        //                             listen: false)
                        //                         .markData("bookmark",
                        //                             appState.item.id, 1);
                        //                   },
                        //                   child: activeIcons.saveCircle),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              const EdgeInsets.symmetric(
                                                  vertical: 5)),
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
                                                    type: appState.item.title,
                                                    cover:
                                                        appState.item.thumbnail,
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
                                                      type: appState.item.title,
                                                      id: appState.item.id)),
                                        );
                                      }
                                    },
                                    child: Column(
                                      children: const [
                                        Icon(Icons.music_note),
                                        Text(
                                          "Listen",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // posters
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              const EdgeInsets.symmetric(
                                                  vertical: 5)),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.blue),
                                    ),
                                    onPressed: () {
                                      if (appState.item.isSub) {
                                        if (widget
                                            .data.poster_image.isNotEmpty) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PosterListScreen(
                                                      type: appState.item.title,
                                                      files: appState
                                                          .item.posters),
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
                                                      type: appState.item.title,
                                                      id: appState.item.id)),
                                        );
                                      }
                                    },
                                    child: Column(
                                      children: const [
                                        Icon(Icons.image),
                                        Text(
                                          "Image",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // work book
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              const EdgeInsets.symmetric(
                                                  vertical: 5)),
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
                                            builder: (context) => PdfListScreen(
                                              type: appState.item.title,
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
                                                      type: appState.item.title,
                                                      id: appState.item.id)),
                                        );
                                      }
                                    },
                                    child: Column(
                                      children: const [
                                        Icon(Icons.document_scanner),
                                        Text(
                                          "Workbook",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // videos
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              const EdgeInsets.symmetric(
                                                  vertical: 5)),
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
                                              type: appState.item.title,
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
                                                      type: appState.item.title,
                                                      id: appState.item.id)),
                                        );
                                      }
                                    },
                                    child: Column(
                                      children: const [
                                        Icon(Icons.tv),
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
                            tagsList: Html.tags,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}