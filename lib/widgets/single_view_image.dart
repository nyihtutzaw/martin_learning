import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class SingleViewImage extends StatelessWidget {
  const SingleViewImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PhotoView(
          imageProvider: NetworkImage(image),
        ),
      ),
    );
  }
}
