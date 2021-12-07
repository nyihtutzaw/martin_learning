import 'package:flutter/material.dart';

import '../constants/active_constants.dart';

class OneZOneWidget extends StatelessWidget {
  const OneZOneWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 240.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(width: 5.0),
            SizedBox(
              width: deviceWidth < 400.0 ? 180.0 : 200.0,
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
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const Home(),
                //   ),
                // );
              },
              child: activeIcons.download,
            ),
          ],
        ),
      ),
    );
  }
}
