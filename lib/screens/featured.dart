import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimize/models/OneZOne.dart';
import 'package:optimize/providers/feature_provider.dart';
import 'package:optimize/widgets/full_screen_preloader.dart';
import 'package:provider/provider.dart';

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
  bool _isInit = false;
  bool _isPreloading = false;

  void loadData() async {
    setState(() {
      _isPreloading = true;
    });

    await Provider.of<FeatureProvider>(context, listen: false).getAll();

    setState(() {
      _isPreloading = false;
    });
  }

  void didChangeDependencies() {
    if (!_isInit) {
      loadData();
      _isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: _isPreloading
              ? FullScreenPreloader()
              : Consumer<FeatureProvider>(builder: (context, appState, child) {
                  return Column(
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
                      Column(
                        children: [
                          for (var item in appState.pns)
                            PNWidget(
                              data: item,
                              marginBottom: 10,
                            ),
                        ],
                      ),
                      const SizedBox(height: 25.0),
                      Column(
                        children: [
                          for (var item in appState.plusOnes)
                            PlusOneWidget(
                              data: item,
                              marginBottom: 10,
                            ),
                        ],
                      ),
                      const SizedBox(height: 25.0),
                      Column(
                        children: [
                          for (var item in appState.ozOnes)
                            OneZOneWidget(
                              data: item,
                              marginBottom: 10,
                            ),
                        ],
                      ),
                    ],
                  );
                })),
    );
  }
}
