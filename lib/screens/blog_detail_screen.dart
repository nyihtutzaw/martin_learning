import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:optimize/models/BlogModel.dart';
import 'package:transparent_image/transparent_image.dart';

class BlogDetailScreen extends StatelessWidget {
  final BlogModel blog;

  const BlogDetailScreen({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mar Thin"),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            FadeInImage.memoryNetwork(
                placeholder: kTransparentImage, image: this.blog.image),
            Html(data: this.blog.content, style: {
              // tables will have the below background color
              "p": Style(
                lineHeight: LineHeight.number(2),
              ),
            }),
          ],
        )),
      ),
    );
  }
}
