import 'package:flutter/material.dart';

import '../screens/search.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
    required this.title,
    required this.bgColor,
  }) : super(key: key);

  final String title;
  final Color bgColor;

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0.0,
      centerTitle: false,
      titleSpacing: 0.0,
      // automaticallyImplyLeading: false,
      // leading: Row(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 10.0),
      //       child: SizedBox(
      //         height: 25.0,
      //         child: VerticalDivider(
      //           color: Colors.grey,
      //           thickness: 0.7,
      //           width: 1.0,
      //         ),
      //       ),
      //     ),
      //     GestureDetector(
      //       onTap: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => const Search(),
      //           ),
      //         );
      //       },
      //       child: const Icon(
      //         Icons.search,
      //         color: Colors.white,
      //         size: 25.0,
      //       ),
      //     ),
      //   ],
      // ),
      // title: Text(title),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
                  size: 25.0,
                ),
              ),
            ],
          ),
          const SizedBox(width: 25.0),
          Text(title),
          const SizedBox(width: 25.0),
          const Icon(Icons.filter_list),
          const SizedBox(width: 1.0),
        ],
      ),
    );
  }
}
