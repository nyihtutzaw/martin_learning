import 'package:flutter/material.dart';

import '../constants/active_constants.dart';
import '../screens/search.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    Key? key,
    required this.currentIndex,
    required this.bgColor,
  }) : super(key: key);

  final int currentIndex;
  final Color bgColor;

  static const List<String> _pageNames = [
    'Featured',
    '+1s',
    'PhilosophersNotes',
    'Master Classes',
    'My Lists',
  ];

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppBar(
          backgroundColor: bgColor,
          elevation: 0.0,
          centerTitle: false,
          titleSpacing: 0.0,
          titleTextStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              currentIndex == 0 || currentIndex == 4
                  ? const Text('')
                  : Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: SizedBox(
                            height: 25.0,
                            child: VerticalDivider(
                              color: Colors.grey,
                              thickness: 0.7,
                              width: 1.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Search(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 24.0,
                          ),
                        ),
                      ],
                    ),
              const SizedBox(width: 1.0),
              const SizedBox(width: 1.0),
              const SizedBox(width: 1.0),
              const SizedBox(width: 1.0),
              Text(_pageNames[currentIndex]),
              const SizedBox(width: 5.0),
              const SizedBox(width: 5.0),
              const SizedBox(width: 5.0),
              const SizedBox(width: 5.0),
              currentIndex == 0 || currentIndex == 4
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Search(),
                          ),
                        );
                      },
                      child: activeIcons.search,
                    )
                  : activeIcons.filter,
              const SizedBox(width: 1.0),
            ],
          ),
        ),
      ],
    );
  }
}
