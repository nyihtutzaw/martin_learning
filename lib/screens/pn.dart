import 'package:flutter/material.dart';

import '../constants/active_constants.dart';
import '../widgets/pn_widget.dart';

class PN extends StatefulWidget {
  const PN({Key? key}) : super(key: key);

  @override
  _PNState createState() => _PNState();
}

class _PNState extends State<PN> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const SizedBox(height: 20.0),
              const PNWidget(),
              const SizedBox(height: 7.0),
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
