import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:optimize/constants/active_constants.dart';
import 'package:optimize/providers/subscription_provider.dart';
import 'package:provider/provider.dart';
import 'full_screen_preloader.dart';

class PremiumMessage extends StatefulWidget {
  final Function onClick;
  final String type;
  final int id;
  const PremiumMessage(
      {Key? key, required this.onClick, required this.type, required this.id})
      : super(key: key);

  @override
  State<PremiumMessage> createState() => _PremiumMessageState();
}

class _PremiumMessageState extends State<PremiumMessage> {
  bool _isInit = false;
  bool _isPreloading = false;

  void loadData() async {
    setState(() {
      _isPreloading = true;
    });
    try {
      if (widget.type == "pn") {
        await Provider.of<SubscriptionProvider>(context, listen: false)
            .getAll(widget.type, widget.id);
      } else if (widget.type == "101") {
        await Provider.of<SubscriptionProvider>(context, listen: false)
            .getAll(widget.type, widget.id);
      }
    } catch (error) {
      print(error);
    } finally {
      setState(() {
        _isPreloading = false;
      });
    }
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
    return Center(
        child: _isPreloading
            ? FullScreenPreloader()
            : Consumer<SubscriptionProvider>(
                builder: (context, appState, child) {
                return Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.1),
                        child: Html(
                          data: appState.description,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20),
                            backgroundColor: activeColors.primary),
                        onPressed: () {
                          widget.onClick();
                        },
                        child: const Text(
                          'Get Now',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              }));
  }
}
