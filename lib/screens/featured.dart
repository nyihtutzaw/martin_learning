import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/plus_one_widget.dart';
import '../widgets/pn_widget.dart';
import '../widgets/one_z_one_widget.dart';
import '../constants/active_constants.dart';

class Featured extends StatefulWidget {
  const Featured({Key? key}) : super(key: key);

  @override
  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  final List<String> _categories = [
    'algorithms',
    'habits',
    'best-of-optimize',
    'celebrate',
    'willpower',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25.0),
            Center(
              child: Text(
                'Daily Wisdom',
                style: activeTextStyles.header,
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: Text(
                'A daily guided tour through the most',
                style: activeTextStyles.description,
              ),
            ),
            Center(
              child: Text(
                'life-changing wisdom from the Optimize library.',
                style: activeTextStyles.description,
              ),
            ),
            const SizedBox(height: 36.0),
            PNWidget(categories: _categories),
            const SizedBox(height: 25.0),
            const PlusOneWidget(),
            const SizedBox(height: 25.0),
            const OneZOneWidget(),
          ],
        ),
      ),
    );
  }
}
