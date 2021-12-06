import 'package:flutter/material.dart';

import '../constants/active_constants.dart';

class OneZOneWidget extends StatelessWidget {
  const OneZOneWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 90,
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
            const SizedBox(width: 5.0),
            SizedBox(
              width: 180.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Stoicism 101',
                    style: activeTextStyles.title,
                  ),
                  Text(
                    'How to apply the Ancient Wisdom of Semeca, Epictetus and Marcus Aurelius to Your Modern Life',
                    style: activeTextStyles.caption,
                  ),
                  Text(
                    'I love Stoicism. In this class, we take a quick look at the cast of characters (From founder Zeno to Seneca + Ep...',
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
