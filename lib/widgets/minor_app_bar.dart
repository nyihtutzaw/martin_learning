import 'package:flutter/material.dart';

import '../constants/active_constants.dart';

class MinorAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MinorAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppBar(
          backgroundColor: activeColors.primary,
          elevation: 0.0,
          centerTitle: true,
          titleSpacing: 0.0,
          titleTextStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
          title: Column(
            children: [
              const SizedBox(height: 3.0),
              const Text('Optimize'),
              const SizedBox(height: 3.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
