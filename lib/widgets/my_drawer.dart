import 'package:flutter/material.dart';

import '../constants/active_constants.dart';

class DrawerItem {
  final IconData icon;
  final String pageName;
  final String route;

  const DrawerItem({
    required this.icon,
    required this.pageName,
    required this.route,
  });
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DrawerItem> drawerItems = [
      DrawerItem(
        icon: activeIcons.home,
        pageName: 'Home',
        route: '/home',
      ),
      DrawerItem(
        icon: activeIcons.diam,
        pageName: 'Featured',
        route: '/featured',
      ),
      DrawerItem(
        icon: activeIcons.noti,
        pageName: 'Notifications',
        route: '/noti',
      ),
      DrawerItem(
        icon: activeIcons.cloud,
        pageName: 'Offline content',
        route: '/offline_content',
      ),
      DrawerItem(
        icon: activeIcons.profile,
        pageName: 'Manage Profile',
        route: '/profile',
      ),
      DrawerItem(
        icon: activeIcons.walker,
        pageName: 'Log Out',
        route: '/log_out',
      ),
    ];

    return Drawer(
      child: SafeArea(
        child: Container(
          color: activeColors.black,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 23.0,
                  top: 15.0,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 45.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: activeColors.primary,
                      ),
                      child: Center(
                        child: Text(
                          'YN',
                          style: TextStyle(
                            color: activeColors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      'Your Name',
                      style: TextStyle(
                        color: activeColors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                height: 300.0,
                child: ListView(
                  padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                  children: drawerItems
                      .map(
                        (item) => DrawerTile(
                          title: item.pageName,
                          icon: item.icon,
                          route: item.route,
                        ),
                      )
                      .toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(width: 10.0),
                  Text(
                    'MORE GOODNESS',
                    style: TextStyle(
                      color: activeColors.primary,
                      fontSize: 10.0,
                    ),
                  ),
                  SizedBox(
                    width: 174.0,
                    child: Divider(
                      color: activeColors.primary,
                      height: 1.0,
                      thickness: 1.0,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 16, right: 16),
                child: DrawerTile(
                  title: 'Optimize Podcast',
                  icon: activeIcons.podcast,
                  route: '/podcast',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;

  const DrawerTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, route);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 23,
              color: activeColors.grey,
            ),
            const SizedBox(width: 5.0),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                title,
                style: activeTextStyles.drawer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
