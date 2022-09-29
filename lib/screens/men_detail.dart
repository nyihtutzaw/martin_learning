import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:optimize/models/MenModel.dart';
import 'package:transparent_image/transparent_image.dart';

class MenDetail extends StatelessWidget {
  final MenModel menModel;

  const MenDetail({
    Key? key,
    required this.menModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("မာသင်"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FadeInImage.memoryNetwork(
                placeholder: kTransparentImage, image: menModel.image),
            const SizedBox(height: 3.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  menModel.title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 3.0),
            Html(data: menModel.subtitle),
            Html(data: menModel.body, style: {
              // tables will have the below background color
              "p": Style(
                lineHeight: LineHeight.number(2),
              ),
            }),
          ],
        ),
      ),
    );
  }
}
