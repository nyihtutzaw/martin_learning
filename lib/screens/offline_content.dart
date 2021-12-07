import 'package:flutter/material.dart';
import '../constants/active_constants.dart';

import '../widgets/minor_app_bar.dart';
import '../widgets/my_drawer.dart';

class OfflineContent extends StatefulWidget {
  const OfflineContent({Key? key}) : super(key: key);

  @override
  _OfflineContentState createState() => _OfflineContentState();
}

class _OfflineContentState extends State<OfflineContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: activeColors.white,
      appBar: const MinorAppBar(title: 'Offline Content'),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 30.0,
                  width: double.infinity,
                  color: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                    child: Text(
                      '+1S',
                      style: activeTextStyles.title.copyWith(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
                const PlusOneWidget(),
              ],
            ),
            Column(
              children: [
                Container(
                  height: 30.0,
                  width: double.infinity,
                  color: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                    child: Text(
                      'PHILOSOPHERSNOTES',
                      style: activeTextStyles.title.copyWith(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
                const PNWidget(),
              ],
            ),
            Column(
              children: [
                Container(
                  height: 30.0,
                  width: double.infinity,
                  color: Colors.grey.shade100,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                    child: Text(
                      'Master Classes',
                      style: activeTextStyles.title.copyWith(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
                const OneZOneWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PNWidget extends StatelessWidget {
  const PNWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        const SizedBox(height: 20.0),
        SizedBox(
          height: 180.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('PN!');
                      },
                      child: Container(
                        width: deviceWidth < 400.0 ? 100.0 : 120.0,
                        height: deviceWidth < 400.0 ? 136.0 : 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: const DecorationImage(
                            image: NetworkImage(
                              "https://images.unsplash.com/photo-1487029413235-e3f7a0e8e140?fit=crop&w=1050&q=80",
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      '17.5 MB',
                      style: activeTextStyles.small.copyWith(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 15.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tiny Habits',
                      style: activeTextStyles.title,
                    ),
                    SizedBox(
                      width: deviceWidth < 400.0 ? 230.0 : 250.0,
                      child: Text(
                        'The Small Changes That Change Everything',
                        style: activeTextStyles.caption,
                      ),
                    ),
                    Text(
                      'B. J. Fogg',
                      style: activeTextStyles.author,
                    ),
                    const SyncedButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 7.0),
        Divider(
          height: 2.0,
          thickness: 1.0,
          color: activeColors.grey,
        ),
      ],
    );
  }
}

class PlusOneWidget extends StatelessWidget {
  const PlusOneWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        const SizedBox(height: 20.0),
        SizedBox(
          height: 120.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('Plus One!');
                      },
                      child: Container(
                        width: deviceWidth < 400.0 ? 123.0 : 133.0,
                        height: deviceWidth < 400.0 ? 75.0 : 90.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: const DecorationImage(
                            image: NetworkImage(
                              "https://images.unsplash.com/photo-1541329164087-0283eda68eda?fit=crop&w=634&q=80",
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: activeIcons.playerCircleFill,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      '22.1 MB',
                      style: activeTextStyles.small.copyWith(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 5.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: deviceWidth < 400.0 ? 210.0 : 240.0,
                      child: Wrap(
                        children: [
                          Text(
                            'How to Celebrate',
                            style: activeTextStyles.title,
                          ),
                          Text(
                            '#1207',
                            style: activeTextStyles.muted,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 180.0,
                      child: Text(
                        'Hint: IMMEDIATELY + INTENSELY',
                        style: activeTextStyles.caption,
                      ),
                    ),
                    const SyncedButton(),
                  ],
                ),
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
    );
  }
}

class OneZOneWidget extends StatelessWidget {
  const OneZOneWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        const SizedBox(height: 20.0),
        SizedBox(
          height: 210.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('One Zero One!');
                      },
                      child: Container(
                        width: deviceWidth < 400.0 ? 123.0 : 133.0,
                        height: deviceWidth < 400.0 ? 75.0 : 90.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: const DecorationImage(
                            image: NetworkImage(
                              "https://images.unsplash.com/photo-1513149739851-50f01dfcbd9a?fit=crop&w=1350&q=80",
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: activeIcons.playerCircleFill,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      '71.1 MB',
                      style: activeTextStyles.small.copyWith(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 5.0),
                SizedBox(
                  width: deviceWidth < 400.0 ? 210.0 : 240.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Positive Psychology 101',
                        style: activeTextStyles.title,
                      ),
                      Text(
                        'How to Tap into the Science of Optimizing + Actualizing',
                        style: activeTextStyles.caption,
                      ),
                      Text(
                        'I LOVE the science of flourishing. In this class, we have fun exploring my absolute favorite Big Ideas from my...',
                        style: activeTextStyles.small.copyWith(
                          fontSize: 16.0,
                        ),
                      ),
                      const SyncedButton(),
                    ],
                  ),
                ),
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
    );
  }
}

class SyncedButton extends StatelessWidget {
  const SyncedButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(
        width: 100,
        height: 27,
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          primary: activeColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 0.0,
            horizontal: 20.0,
          ),
          textStyle: activeTextStyles.title.copyWith(
            color: activeColors.white,
            fontSize: 10.0,
          ),
        ),
        child: Center(
          child: Row(
            children: const [
              Icon(
                Icons.check,
                size: 15.0,
              ),
              SizedBox(width: 5.0),
              Text('Synced'),
            ],
          ),
        ),
      ),
    );
  }
}
