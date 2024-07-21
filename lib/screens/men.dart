import 'package:flutter/material.dart';
import 'package:optimize/providers/idea_provider.dart';
import 'package:optimize/providers/one_z_one_provider.dart';
import 'package:optimize/providers/sort_provider.dart';
import 'package:optimize/widgets/full_screen_preloader.dart';
import 'package:optimize/widgets/home_app_bar.dart';
import 'package:optimize/widgets/idea_widget.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants/active_constants.dart';
import '../widgets/one_z_one_widget.dart';
import 'idea.dart';

class Men extends StatefulWidget {
  const Men({Key? key}) : super(key: key);

  @override
  _MenState createState() => _MenState();
}

class _MenState extends State<Men> {

    bool _isInit = false;

  void loadData() async {
     await Provider.of<IdeaProvider>(context, listen: false).checkSubscribed();
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
      return  appState.isSubscribed?Scaffold(
        appBar: HomeAppBar(currentIndex: 5, bgColor: activeColors.primary,),
        body: Idea()
      ):Positioned(
        top: -20,
        child: WebView(initialUrl: 'https://marthin.org/ld-groups/bizdea-membership',));
    });
  }
}
