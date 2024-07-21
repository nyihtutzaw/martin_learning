import 'package:flutter/material.dart';
import 'package:optimize/providers/idea_provider.dart';
import 'package:optimize/providers/one_z_one_provider.dart';
import 'package:optimize/providers/sort_provider.dart';
import 'package:optimize/widgets/full_screen_preloader.dart';
import 'package:optimize/widgets/idea_widget.dart';
import 'package:provider/provider.dart';

import '../constants/active_constants.dart';
import '../widgets/one_z_one_widget.dart';

class Idea extends StatefulWidget {
  const Idea({Key? key}) : super(key: key);

  @override
  _IdeaState createState() => _IdeaState();
}

class _IdeaState extends State<Idea> {
  bool _isInit = false;

  void loadData() async {
    if (Provider.of<IdeaProvider>(context, listen: false).items.isEmpty) {
      bool sorted = Provider.of<SortProvider>(context, listen: false).sort;
      await Provider.of<IdeaProvider>(context, listen: false).getAll(sorted);
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
    return Consumer<IdeaProvider>(builder: (context, appState, child) {
      return Container(
        child: appState.ideaLoading
            ? FullScreenPreloader()
            : ListView.builder(
                itemCount: appState.items.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(height: 20.0),
                      IdeaWidget(data: appState.items[index]),
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
