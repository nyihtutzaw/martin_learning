
import 'package:flutter/material.dart';
import 'package:optimize/models/Poster.dart';
import 'package:optimize/screens/photo_view_screen.dart';
import 'package:url_launcher/url_launcher.dart';


import '../constants/active_constants.dart';

class PosterListScreen extends StatelessWidget {
  List<Poster> files = [];
  String type;
  PosterListScreen({Key? key, required this.files, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: activeColors.primary,
          title: Text("$type: Poster"),
          centerTitle: false,
          titleSpacing: 0.0,
          titleTextStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: ListView.builder(
          itemCount: files.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoViewScreen(
                        image: files[index].url
                    ),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                    title: Text(files[index].name),
                    leading: const Icon(Icons.photo),
                    trailing: TextButton(
                    child: Text("Download"),
                    onPressed: () async {
                      final url = files[index].url;
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                    
                    ),
              ),
            );
          },
        ));
  }
}
