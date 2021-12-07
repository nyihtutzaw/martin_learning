import 'package:flutter/material.dart';

import '../constants/active_constants.dart';
import '../widgets/plus_one_widget.dart';

class PlusOne extends StatefulWidget {
  const PlusOne({Key? key}) : super(key: key);

  @override
  _PlusOneState createState() => _PlusOneState();
}

class _PlusOneState extends State<PlusOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const SizedBox(height: 20.0),
              const PlusOneWidget(),
              const SizedBox(height: 10.0),
              Divider(
                height: 2.0,
                thickness: 1.0,
                color: activeColors.grey,
              ),
            ],
          );
        },
      ),
    );
  }
}
