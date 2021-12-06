import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/active_constants.dart';

class Featured extends StatefulWidget {
  const Featured({Key? key}) : super(key: key);

  @override
  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  final List<String> _categories = [
    'algorithms',
    'habits',
    'best-of-optimize',
    'celebrate',
    'willpower',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25.0),
            Center(
              child: Text(
                'Daily Wisdom',
                style: activeTextStyles.header,
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: Text(
                'A daily guided tour through the most',
                style: activeTextStyles.description,
              ),
            ),
            Center(
              child: Text(
                'life-changing wisdom from the Optimize library.',
                style: activeTextStyles.description,
              ),
            ),
            const SizedBox(height: 36.0),
            SizedBox(
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
                            "https://images.unsplash.com/photo-1515688594390-b649af70d282?fit=crop&w=995&q=80",
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
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
            ),
          ],
        ),
      ),
    );
  }
}
