import 'package:dac/modules/home_screen/home_screen.dart';
import 'package:dac/shared/cash_helper.dart';
import 'package:dac/shared/dio_helper.dart';
import 'package:flutter/foundation.dart';
// import 'package:dac/shared/notifications/local_notifications.dart';
// import 'package:dac/shared/notifications/notifications_service.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'modules/login_screen/login_screen.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  //await FirebaseMessaging.instance.requestPermission();
  //LocalNotificationService.initialize();
  DioHelper.init();
  await CashHelper.init();
  runApp(const MyApp());
  // if(CashHelper.getUserToken() != null){
  //   NotificationService notificationService=NotificationService();
  //   await notificationService.initialise();
  // }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        disabledColor: Colors.grey[600],
        primarySwatch: Colors.blue,
        fontFamily: 'Comic',
        textTheme: const TextTheme(
            bodyText1: TextStyle(fontSize: kIsWeb ? 25.0 : 15.0, color: Colors.black),
          bodyText2: TextStyle(fontSize: kIsWeb ? 30.0 : 17.0, color: Colors.white),
          headline1: TextStyle(fontSize: kIsWeb ? 30.0 : 17.0, color: Colors.blue),
          //bodyLarge: TextStyle(fontSize: kIsWeb ? 35.0 : 15.0, color: Colors.blue),
        ),
        buttonTheme: const ButtonThemeData(
          height: kIsWeb ? 300 : 50
        )
      ),
      home: CashHelper.getUserToken() != null
          ? HomeScreen()
          : const LoginScreen(),
    );
  }
}
