import 'package:flutter/material.dart';

class PlusOne extends StatefulWidget {
  const PlusOne({Key? key}) : super(key: key);

  @override
  _PlusOneState createState() => _PlusOneState();
}

class _PlusOneState extends State<PlusOne> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('+1'),
    );
  }
}
