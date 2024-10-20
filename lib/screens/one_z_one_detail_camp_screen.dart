import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:optimize/models/OneZOne.dart';
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
import 'audio_list_screen.dart';

class OneZOneDetailCampScreen extends StatefulWidget {
  const OneZOneDetailCampScreen({Key? key}) : super(key: key);

  @override
  State<OneZOneDetailCampScreen> createState() =>
      _OneZOneDetailCampScreenState();
}

class _OneZOneDetailCampScreenState extends State<OneZOneDetailCampScreen> {
  bool _isInit = false;
  bool _isPreloading = false;

  void loadData() async {
    setState(() {
      _isPreloading = true;
    });
    try {
      await Provider.of<OneZOneProvider>(context, listen: false)
          .getCampCourse();
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

  Future<void> onSubscribe(int id) async {
    await Provider.of<OneZOneProvider>(context, listen: false)
        .subscribeCourse(id);
    MessageDialog.show(
        context,
        "admin မှ လက်ခံပေးပါမယ် ခဏစောင့်ပြီး ပြန်ဝင်ကြည့်ပါ",
        "Success",
        "Close");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OneZOneProvider>(builder: (context, appState, child) {

      if (appState.campItem==null) return Scaffold(
          body: Center(child: Text("Please contact your admin")),
      );

      return Scaffold(
        appBar: AppBar(
          backgroundColor: activeColors.primary,
          title: Text(appState.campItem!=null?appState.campItem.title:""),
          centerTitle: true,
          titleSpacing: 0.0,
          titleTextStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: SingleChildScrollView(
            child: _isPreloading
                ? FullScreenPreloader()
                : Container(
                    child: Column(
                      children: [
                        // video thumbnail
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoViewScreen(
                                  url: appState.campItem.video,
                                  isUbube: appState.campItem.isUtube,
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
                                image:
                                    NetworkImage(appState.campItem.thumbnail),
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
                              Text(appState.campItem.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  )),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                appState.campItem.subtitle,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  appState.campItem.isLiked
                                      ? GestureDetector(
                                          onTap: () async {
                                            await Provider.of<OneZOneProvider>(
                                                    context,
                                                    listen: false)
                                                .markData("like",
                                                    appState.campItem.id, 0);
                                          },
                                          child: activeIcons.heartCircleFill)
                                      : GestureDetector(
                                          onTap: () async {
                                            await Provider.of<OneZOneProvider>(
                                                    context,
                                                    listen: false)
                                                .markData("like",
                                                    appState.campItem.id, 1);
                                          },
                                          child: activeIcons.heartCircle),
                                  const SizedBox(width: 10.0),
                                  appState.campItem.isTipped
                                      ? GestureDetector(
                                          onTap: () async {
                                            await Provider.of<OneZOneProvider>(
                                                    context,
                                                    listen: false)
                                                .markData("tip",
                                                    appState.campItem.id, 0);
                                          },
                                          child: activeIcons.checkCircleFill)
                                      : GestureDetector(
                                          onTap: () async {
                                            await Provider.of<OneZOneProvider>(
                                                    context,
                                                    listen: false)
                                                .markData("tip",
                                                    appState.campItem.id, 1);
                                          },
                                          child: activeIcons.checkCircle),
                                  const SizedBox(width: 10.0),
                                  appState.campItem.isBooked
                                      ? GestureDetector(
                                          onTap: () async {
                                            await Provider.of<OneZOneProvider>(
                                                    context,
                                                    listen: false)
                                                .markData("bookmark",
                                                    appState.campItem.id, 0);
                                          },
                                          child: activeIcons.saveCircleFill)
                                      : GestureDetector(
                                          onTap: () async {
                                            await Provider.of<OneZOneProvider>(
                                                    context,
                                                    listen: false)
                                                .markData("bookmark",
                                                    appState.campItem.id, 1);
                                          },
                                          child: activeIcons.saveCircle),
                                ],
                              ),
                            ],
                          ),
                        ),
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
                                      if (appState.campItem.isSub) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AudioListScreen(
                                                    type: "101",
                                                    cover: appState
                                                        .campItem.thumbnail,
                                                    subTitle:
                                                        appState.campItem.title,
                                                    files: appState
                                                        .campItem.audioFiles,
                                                  )),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PremiumMessage(
                                                      onClick: () =>
                                                          onSubscribe(appState
                                                              .campItem.id),
                                                      type: "101",
                                                      id: appState
                                                          .campItem.id)),
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
                                      if (appState.campItem.isSub) {
                                        if (appState
                                            .campItem.poster_image.isNotEmpty) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PosterListScreen(
                                                      type: "101",
                                                      files: appState
                                                          .campItem.posters),
                                            ),
                                          );
                                        }
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PremiumMessage(
                                                      onClick: () =>
                                                          onSubscribe(appState
                                                              .campItem.id),
                                                      type: "101",
                                                      id: appState
                                                          .campItem.id)),
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
                                      if (appState.campItem.isSub) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PdfListScreen(
                                              type: "101",
                                              files: appState.campItem.pdfFiles,
                                            ),
                                          ),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PremiumMessage(
                                                      onClick: () =>
                                                          onSubscribe(appState
                                                              .campItem.id),
                                                      type: "101",
                                                      id: appState
                                                          .campItem.id)),
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
                                      if (appState.campItem.isSub) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                VideoListScreen(
                                              type: "101",
                                              files:
                                                  appState.campItem.videoFiles,
                                            ),
                                          ),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PremiumMessage(
                                                      onClick: () =>
                                                          onSubscribe(appState
                                                              .campItem.id),
                                                      type: "101",
                                                      id: appState
                                                          .campItem.id)),
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
                            data: appState.campItem.description,
                            tagsList: Html.tags,
                          ),
                        ),
                      ],
                    ),
                  )),
      );
    });
  }
}
