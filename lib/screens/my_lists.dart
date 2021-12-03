import 'package:flutter/material.dart';

class MyLists extends StatefulWidget {
  const MyLists({Key? key}) : super(key: key);

  @override
  _MyListsState createState() => _MyListsState();
}

class _MyListsState extends State<MyLists> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('My Lists'),
    );
  }
}
