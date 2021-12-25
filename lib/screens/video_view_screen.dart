import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

// import 'custom_ui.dart';

class VideoViewScreen extends StatefulWidget {
  final String url;

  VideoViewScreen({required this.url});

  @override
  _VideoViewScreenState createState() => _VideoViewScreenState();
}

class _VideoViewScreenState extends State<VideoViewScreen> {
  final FijkPlayer player = FijkPlayer();

  _VideoViewScreenState();

  @override
  void initState() {
    super.initState();

    player.setOption(FijkOption.playerCategory, "mediacodec-all-videos", 1);
    startPlay();
  }

  void startPlay() async {
    await player.setOption(FijkOption.hostCategory, "request-screen-on", 1);
    await player.setOption(FijkOption.hostCategory, "request-audio-focus", 1);
    await player.setDataSource(widget.url, autoPlay: true).catchError((e) {
      print("setDataSource error: $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: FijkView(
            player: player,
            panelBuilder: fijkPanel2Builder(snapShot: true),
            fsFit: FijkFit.fill,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }
}
