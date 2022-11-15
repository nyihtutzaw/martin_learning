import 'package:flutter/material.dart';
import 'package:optimize/providers/sort_provider.dart';
import 'package:optimize/providers/three_minutes_provider.dart';
import 'package:optimize/widgets/full_screen_preloader.dart';
import 'package:optimize/widgets/three_minutes_widget.dart';
import 'package:provider/provider.dart';

import '../constants/active_constants.dart';

class ThreeMinture extends StatefulWidget {
  const ThreeMinture({Key? key}) : super(key: key);

  @override
  _ThreeMintureState createState() => _ThreeMintureState();
}

class _ThreeMintureState extends State<ThreeMinture> {
  bool _isInit = false;

  void loadData() async {
    if (Provider.of<ThreeMinutesProvider>(context, listen: false)
        .items
        .isEmpty) {
      bool sorted = Provider.of<SortProvider>(context, listen: false).sort;
      await Provider.of<ThreeMinutesProvider>(context, listen: false)
          .getAll(sorted);
    }
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      loadData();
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThreeMinutesProvider>(
        builder: (context, appState, child) {
          return Scaffold(
            body: appState.threeMinuteLoading
                ? FullScreenPreloader()
                : ListView.builder(
              itemCount: appState.items.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(height: 20.0),
                    ThreeMinutesWidget(data: appState.items[index]),
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
    );
  }
}
