import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:optimize/screens/blog_page_screen.dart';
import 'package:optimize/screens/men.dart';
import 'package:optimize/screens/three_minute.dart';
import 'package:optimize/services/local_notification_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constants/chat_api.dart';
import 'main.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/my_drawer.dart';
import 'constants/active_constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

// screens
import 'screens/plus_one.dart';
import 'screens/pn.dart';
import 'screens/one_z_one.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final LocalNotificationService service;
  late io.Socket socket;

  int _selectedIndex = 0;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static const List<Widget> _pages = <Widget>[
    PlusOne(),
    ThreeMinture(),
    PN(),
    OneZeroOne(),
    BlogPageScreen(),
    Men(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    socket = io.io(
        path,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
    service = LocalNotificationService();
    service.intialize();
    // showNotification();
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("FirebaseMessaging.onMessageOpenedApp.listen remoteMessage");
      print(message);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
    _fcmSubscribe();
  }

  void showNotification() {
    socket.on('notification-receive', (data) async {
      await service.showNotification(
          id: 0, title: data['title'], body: data['body']);
    });
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  void _fcmSubscribe() async {
    print("fcm_build_3 ...");
    try {
      await FirebaseMessaging.instance.subscribeToTopic('fcm_build_3');
      print("fcm_build_3 subscribed");
    } catch (exp) {
      print("fcm_build_3 subscribe fail exp");
      print(exp);
    }
  }

  void _showDialogOwn() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text("title"),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [Text("body"), Text("another message")],
              ),
            ),
            actions: [
              InkWell(
                child: const Text("Update"),
                onTap: () {
                  print("update on tap");
                  // open playstore link in web
                  Navigator.pop(context);
                  _launchURL("https://google.com");
                },
              )
            ],
          );
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
      //floatingActionButton: _fab(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: activeIcons.calendar,
            label: '+1',
          ),
          BottomNavigationBarItem(
            icon: activeIcons.calendar,
            label: '3min',
          ),
          BottomNavigationBarItem(
            icon: activeIcons.file,
            label: 'Book',
          ),
          BottomNavigationBarItem(
            icon: activeIcons.player,
            label: 'Course',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Blog',
          ),
          BottomNavigationBarItem(
            icon: activeIcons.diamond,
            label: 'M.E.N',
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

  Widget _fab() {
    return FloatingActionButton(
      onPressed: _showDialogOwn,
      child: const Icon(Icons.refresh),
    );
  }
}
