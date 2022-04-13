import 'package:flutter/material.dart';

class FullScreenPreloader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        //padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5),
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
