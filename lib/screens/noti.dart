import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/active_constants.dart';

import '../widgets/minor_app_bar.dart';
import '../widgets/my_drawer.dart';

class Noti extends StatefulWidget {
  const Noti({Key? key}) : super(key: key);

  @override
  _NotiState createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  bool _noti = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MinorAppBar(title: 'Notifications'),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          MergeSemantics(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 0.0,
              ),
              child: ListTile(
                title: const Text('Receive app notifications'),
                trailing: CupertinoSwitch(
                  activeColor: activeColors.primary,
                  value: _noti,
                  onChanged: (bool value) {
                    setState(() {
                      _noti = value;
                    });
                    print(_noti);
                  },
                ),
                // onTap: () {
                //   setState(() {
                //     _noti = !_noti;
                //   });
                // },
              ),
            ),
          ),
          Divider(
            height: 2.0,
            thickness: 1.0,
            color: activeColors.grey,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const NotiTile();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NotiTile extends StatelessWidget {
  const NotiTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5.0),
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 25.0,
            vertical: 3.0,
          ),
          title: Text(
            'Dec 6 Hellobar (non-members)',
            style: activeTextStyles.title.copyWith(
              fontSize: 16.0,
            ),
          ),
          subtitle: const Padding(
            padding: EdgeInsets.only(top: 7.0),
            child: Text(
                'Big news! Optimize is now FREE! No credit card required. 100% ad-free. No strings attached. Get your free Optimize Premium membership today.'),
          ),
        ),
        const SizedBox(height: 5.0),
        Divider(
          height: 2.0,
          thickness: 1.0,
          color: activeColors.grey,
        ),
      ],
    );
  }
}
