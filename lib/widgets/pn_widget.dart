import 'package:flutter/material.dart';

import '../constants/active_constants.dart';

class PNWidget extends StatelessWidget {
  const PNWidget({
    Key? key,
    required List<String> categories,
  })  : _categories = categories,
        super(key: key);

  final List<String> _categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _categories.length > 4 ? 230.0 : 200.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                // shape: BoxShape.circle,
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1479064555552-3ef4979f8908?fit=crop&w=1350&q=80',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
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
                  width: 200.0,
                  child: Text(
                    'The Small Changes That Change Everything',
                    style: activeTextStyles.caption,
                  ),
                ),
                Text(
                  'B. J. Fogg',
                  style: activeTextStyles.author,
                ),
                Row(
                  children: [
                    Icon(
                      activeIcons.doc,
                      color: activeColors.secondary,
                      size: 18.0,
                    ),
                    const SizedBox(width: 3.0),
                    Text(
                      'Read',
                      style: activeTextStyles.actions,
                    ),
                    const SizedBox(width: 10.0),
                    Icon(
                      activeIcons.volume,
                      color: activeColors.secondary,
                      size: 18.0,
                    ),
                    const SizedBox(width: 3.0),
                    Text(
                      'Listen',
                      style: activeTextStyles.actions,
                    ),
                    const SizedBox(width: 10.0),
                    Icon(
                      activeIcons.playFill,
                      color: activeColors.secondary,
                      size: 18.0,
                    ),
                    const SizedBox(width: 3.0),
                    Text(
                      'Watch',
                      style: activeTextStyles.actions,
                    ),
                  ],
                ),
                SizedBox(
                  width: 200.0,
                  child: Wrap(
                    spacing: 5.0,
                    runSpacing: 6.0,
                    children: _categories
                        .map(
                          (cat) => Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: activeColors.grey,
                              ),
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5.0,
                                horizontal: 6.0,
                              ),
                              child: Text(
                                cat.toUpperCase(),
                                style: activeTextStyles.small,
                              ),
                            ),
                          ),
                        )
                        .toList(),
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
