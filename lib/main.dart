import 'package:app2/firebase_options.dart';
import 'package:app2/pages/auth/auth_home.dart';
import 'package:app2/pages/auth/login_page.dart';
import 'package:app2/pages/auth/signup_page.dart';
import 'package:app2/pages/grid/grid_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '.env';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initAuth();
  await initPayments();

  runApp(const App());

  await initNotifications();
}

initNotifications() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@drawable-xhdpi/ic_stat_name');
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
  );
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  await flutterLocalNotificationsPlugin.show(
    1,
    'You can now claim more credits',
    'Log into Tiles to claim your daily credits',
    NotificationDetails(
      android: AndroidNotificationDetails('1', 'name',
          channelDescription: 'notification'),
    ),
  );
}

initAuth() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

initPayments() async {
  Stripe.publishableKey = STRIPE_PUBLIC_KEY;
  await Stripe.instance.applySettings();
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/login': (context) => AuthPageLoginHome(),
          '/signup': (context) => AuthPageSignupHome(),
          '/login/details': (context) => const LoginPage(),
          '/signup/details': (context) => const SignupPage(),
        },
        theme: ThemeData(
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                  side: MaterialStateProperty.all(
                      BorderSide(color: Colors.black)),
                  iconColor: MaterialStateProperty.all(Colors.black),
                  padding: MaterialStateProperty.all(EdgeInsets.all(10)))),
          appBarTheme: const AppBarTheme(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              elevation: 0),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey,
              textStyle: const TextStyle(fontSize: 14),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                  side: const BorderSide(color: Colors.grey)),
            ),
          ),
        ),
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const GridPage();
              }

              return GridPage();
            }));
  }
}

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Text("hello!"),
        CardFormField(
          controller: CardFormEditController(),
        ),
        ElevatedButton(onPressed: () {}, child: const Text("Pay"))
      ]),
    );
  }
}
