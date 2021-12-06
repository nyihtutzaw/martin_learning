import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants/active_constants.dart';

// screens
import 'home.dart';
import 'onboarding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Real Code Solutions',
      theme: ThemeData(
        fontFamily: 'Acumin',
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/home",
      routes: <String, WidgetBuilder>{
        "/": (BuildContext context) => const Onboarding(),
        "/home": (BuildContext context) => const Home(),
      },
    );
  }
}
