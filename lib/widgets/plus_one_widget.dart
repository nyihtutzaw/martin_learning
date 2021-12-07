import 'package:flutter/material.dart';

import '../constants/active_constants.dart';

class PlusOneWidget extends StatelessWidget {
  const PlusOneWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                // print('Its work!');
              },
              child: Container(
                width: 123.0,
                height: 75.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // shape: BoxShape.circle,
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
            const SizedBox(width: 5.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 180.0,
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
              ],
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
