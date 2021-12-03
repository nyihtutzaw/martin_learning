import 'package:flutter/material.dart';

import 'widgets/my_app_bar.dart';
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
      appBar: _selectedIndex == 3
          ? MyAppBar(title: 'Home', bgColor: activeColors.secondary)
          : MyAppBar(title: 'Home', bgColor: activeColors.primary),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: 'Featured',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: '+1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_drive_file),
            label: 'PN',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outline_rounded),
            label: '101',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
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
