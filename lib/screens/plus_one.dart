import 'package:flutter/material.dart';
import 'package:optimize/providers/plus_one_provider.dart';
import 'package:optimize/providers/sort_provider.dart';
import 'package:optimize/widgets/full_screen_preloader.dart';
import 'package:provider/provider.dart';

import '../constants/active_constants.dart';
import '../widgets/plus_one_widget.dart';

class PlusOne extends StatefulWidget {
  const PlusOne({Key? key}) : super(key: key);

  @override
  _PlusOneState createState() => _PlusOneState();
}

class _PlusOneState extends State<PlusOne> {
  bool _isInit = false;

  void loadData() async {
    if (Provider.of<PlusOneProvider>(context, listen: false).items.isEmpty) {
      bool sorted = Provider.of<SortProvider>(context, listen: false).sort;
      await Provider.of<PlusOneProvider>(context, listen: false)
          .getAll(1, sorted);
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
    return Consumer<PlusOneProvider>(
        builder: (context, appState, child) {
          return Scaffold(
            body: appState.plusOneLoading
                ? FullScreenPreloader()
                : ListView.builder(
              itemCount: appState.items.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(height: 20.0),
                    PlusOneWidget(data: appState.items[index]),
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
