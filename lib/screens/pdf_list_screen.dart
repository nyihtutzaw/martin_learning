import 'package:flutter/material.dart';
import 'package:optimize/constants/active_constants.dart';
import 'package:optimize/models/PdfFile.dart';
import 'package:optimize/screens/pdf_viewer.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfListScreen extends StatelessWidget {
  List<PdfFile> files = [];
  String type;
  PdfListScreen({Key? key, required this.files, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: activeColors.primary,
          title: Text("$type: Pdf Files"),
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
                    builder: (context) => PDFViewScreen(
                        pdf: files[index].url, title: files[index].name),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  title: Text(files[index].name),
                  leading: const Icon(Icons.book),
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
