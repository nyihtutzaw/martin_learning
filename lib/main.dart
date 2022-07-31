import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:optimize/providers/blog_provider.dart';
import 'package:optimize/providers/comment_provider.dart';
import 'package:optimize/providers/feature_provider.dart';
import 'package:optimize/providers/greeting_provider.dart';
import 'package:optimize/providers/my_list_provider.dart';
import 'package:optimize/providers/notification_provider.dart';
import 'package:optimize/providers/one_z_one_provider.dart';
import 'package:optimize/providers/pn_provider.dart';
import 'package:optimize/providers/sort_provider.dart';
import 'package:optimize/providers/subscription_provider.dart';
import 'package:optimize/providers/three_minutes_provider.dart';
import 'package:optimize/screens/sign_in_screen.dart';
import 'package:optimize/screens/sign_up_screen.dart';
import 'package:provider/provider.dart';

import 'constants/active_constants.dart';
// screens
import 'home.dart';
import 'providers/auth_provider.dart';
import 'providers/plus_one_provider.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel_martin', // id
  'High Importance Notifications Martin', // title
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /*
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  String? token = await FirebaseAppCheck.instance.getToken();
  print("AppCheckToken");
  print(token);

   */
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  // await messaging.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProvider.value(
            value: PlusOneProvider(),
          ),
          ChangeNotifierProvider.value(
            value: PnProvider(),
          ),
          ChangeNotifierProvider.value(
            value: OneZOneProvider(),
          ),
          ChangeNotifierProvider.value(
            value: FeatureProvider(),
          ),
          ChangeNotifierProvider.value(
            value: MyListProvider(),
          ),
          ChangeNotifierProvider.value(
            value: NotificationProvider(),
          ),
          ChangeNotifierProvider.value(
            value: SortProvider(),
          ),
          ChangeNotifierProvider.value(
            value: SubscriptionProvider(),
          ),
          ChangeNotifierProvider.value(
            value: BlogProvider(),
          ),
          ChangeNotifierProvider.value(
            value: ThreeMinutesProvider(),
          ),
          ChangeNotifierProvider.value(
            value: GreetingProvider(),
          ),
          ChangeNotifierProvider.value(
            value: CommentProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mar Thin',
          theme: ThemeData(
            // fontFamily: 'Acumin',
            primarySwatch: Colors.blue,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                primary: activeColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 79.0,
                ),
                textStyle: activeTextStyles.title.copyWith(
                  color: activeColors.white,
                ),
              ),
            ),
          ),
          home: Consumer<Auth>(
            builder: (context, auth, child) {
              if (auth.isAuth) {
                return const Home();
              } else {
                return FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const Scaffold(
                              body: Center(
                                child: Text('Loading'),
                              ),
                            )
                          : const SignUpScreen(),
                );
              }
            },
          ),
          routes: <String, WidgetBuilder>{
            //   "/": (BuildContext context) => const Onboarding(),
            //   "/home": (BuildContext context) => const Home(),
            //   "/featured": (BuildContext context) => const FeaturedFull(),
            //   "/noti": (BuildContext context) => const Noti(),
            //   "/offline_content": (BuildContext context) =>
            //       const OfflineContent(),
            //   "/plus_one_detail": (BuildContext context) => const PlusOneDetail(),
            //   "/pn_detail_screen": (BuildContext context) => const PnDetail(),
            "/sign_in_screen": (BuildContext context) => const SignInScreen(),
            //   "/sign_up_screen": (BuildContext context) => const SignUpScreen(),
            //   "/one_z_one_detail_screen": (BuildContext context) =>
            //       const OneZOneDetailScreen(),
            //   "/photo_view_screen": (BuildContext context) =>
            //       const PhotoViewScreen(),
            //   "/pdf_viewer_screen": (BuildContext context) =>
            //       const PDFViewScreen(),
            //   "/video_view_screen": (BuildContext context) => VideoViewScreen(
            //         url:
            //             'http://adminonline.clovermandalay.org/videos/Moe%20Sensei%20Intro.mp4',
            //       ),
          },
        ));
  }
}
