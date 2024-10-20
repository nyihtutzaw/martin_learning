import 'package:flutter/material.dart';
import 'package:optimize/providers/idea_provider.dart';
import 'package:optimize/widgets/home_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants/active_constants.dart';
import 'idea.dart';

class Men extends StatefulWidget {
  const Men({Key? key}) : super(key: key);

  @override
  _MenState createState() => _MenState();
}

class _MenState extends State<Men> {
  bool _isInit = false;

  Future<void> loadData() async {
    try {
      await Provider.of<IdeaProvider>(context, listen: false).checkSubscribed();
    } catch (error) {
      // Handle error if needed
      print('Error loading data: $error');
    }
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      loadData().then((_) {
        setState(() {
          _isInit = true;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IdeaProvider>(builder: (context, appState, child) {
      return appState.isSubscribed
          ? Scaffold(
              appBar: HomeAppBar(
                currentIndex: 5,
                bgColor: activeColors.primary,
              ),
              body: Idea(),
            )
          : Scaffold(
              body: Stack(
                children: [
                  Positioned(
                    top: -20,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: WebView(
                        initialUrl: 'https://marthin.org/ld-groups/bizdea-membership',
                      ),
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
