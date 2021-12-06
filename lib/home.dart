import 'package:flutter/material.dart';

import 'widgets/home_app_bar.dart';
import 'widgets/my_drawer.dart';
import 'constants/active_constants.dart';

// screens
import 'screens/featured.dart';
import 'screens/plus_one.dart';
import 'screens/pn.dart';
import 'screens/one_z_one.dart';
import 'screens/my_lists.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Featured(),
    PlusOne(),
    PN(),
    OneZeroOne(),
    MyLists(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(
        currentIndex: _selectedIndex,
        bgColor: activeColors.primary,
      ),
      drawer: const MyDrawer(),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: activeIcons.diamond,
            label: 'Featured',
          ),
          BottomNavigationBarItem(
            icon: activeIcons.calendar,
            label: '+1',
          ),
          BottomNavigationBarItem(
            icon: activeIcons.file,
            label: 'PN',
          ),
          BottomNavigationBarItem(
            icon: activeIcons.player,
            label: '101',
          ),
          BottomNavigationBarItem(
            icon: activeIcons.heart,
            label: 'My Lists',
          ),
        ],
        backgroundColor: activeColors.black,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: activeColors.white,
        selectedIconTheme: const IconThemeData(size: 20.0),
        selectedLabelStyle: const TextStyle(
          fontSize: 11.0,
        ),
        showSelectedLabels: true,
        unselectedLabelStyle: const TextStyle(
          fontSize: 11.0,
        ),
        unselectedItemColor: Colors.grey.shade700,
        unselectedIconTheme: const IconThemeData(size: 20.0),
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}
