import 'package:flutter/material.dart';

import '../constants/active_constants.dart';
import '../widgets/one_z_one_widget.dart';

class OneZeroOne extends StatefulWidget {
  const OneZeroOne({Key? key}) : super(key: key);

  @override
  _OneZeroOneState createState() => _OneZeroOneState();
}

class _OneZeroOneState extends State<OneZeroOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const SizedBox(height: 20.0),
              const OneZOneWidget(),
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
