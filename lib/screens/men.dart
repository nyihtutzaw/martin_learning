import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:optimize/providers/men_provider.dart';
import 'package:optimize/screens/men_detail.dart';
import 'package:optimize/widgets/full_screen_preloader.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import '../constants/active_constants.dart';

class Men extends StatefulWidget {
  const Men({Key? key}) : super(key: key);

  @override
  State<Men> createState() => _MenState();
}

class _MenState extends State<Men> {
  bool _isInit = false;
  bool _isPreloading = false;
  int page = 1;

  void loadData() async {
    if (Provider.of<MenProvider>(context, listen: true).mens.isEmpty) {
      setState(() {
        _isPreloading = true;
      });

      await Provider.of<MenProvider>(context, listen: false).getAll();

      setState(() {
        _isPreloading = false;
      });
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
    return Scaffold(
      body: _isPreloading
          ? FullScreenPreloader()
          : Consumer<MenProvider>(
              builder: (context, appState, child) {
                return ListView.builder(
                  itemCount: appState.mens.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 20.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MenDetail(menModel: appState.mens[index]),
                                ),
                              );
                            },
                            child: Card(
                              child: Column(
                                children: [
                                  FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: appState.mens[index].image),
                                  Html(data: appState.mens[index].title),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Divider(
                            height: 2.0,
                            thickness: 1.0,
                            color: activeColors.grey,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
