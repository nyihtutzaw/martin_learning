import 'package:flutter/material.dart';
import 'package:optimize/providers/pn_provider.dart';
import 'package:optimize/providers/sort_provider.dart';
import 'package:optimize/widgets/full_screen_preloader.dart';
import 'package:provider/provider.dart';

import '../constants/active_constants.dart';
import '../widgets/pn_widget.dart';

class PN extends StatefulWidget {
  const PN({Key? key}) : super(key: key);

  @override
  _PNState createState() => _PNState();
}

class _PNState extends State<PN> {
  bool _isInit = false;

  void loadData() async {
    if (Provider.of<PnProvider>(context, listen: false).items.isEmpty) {
      bool sorted = Provider.of<SortProvider>(context, listen: false).sort;
      await Provider.of<PnProvider>(context, listen: false).getAll(sorted);
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
    return Consumer<PnProvider>(builder: (context, appState, child) {
      return Scaffold(
        body: appState.pnLoading
            ? FullScreenPreloader()
            : ListView.builder(
                itemCount: appState.items.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(height: 20.0),
                      PNWidget(data: appState.items[index]),
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
    });
  }
}
