import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:dac/modules/home_screen/home_screen.dart';
import 'package:dac/shared/cash_helper.dart';
import 'package:dac/shared/components.dart';
import 'package:dac/shared/constants.dart';
import 'package:dac/shared/dio_helper.dart';
import 'package:dac/shared/notificatinos_service.dart';
import 'package:flutter/material.dart';
import 'modules/login_screen/login_screen.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

Future<void> onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  NotificationsService.onNotification(handleNotification: (data) {
    showNotification(
        id: data['userID'],
        mainTitle: 'Order',
        details: '${data['userName']} has requested ${data['medicineName']}');
  });
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: false,
      notificationChannelId: channelID,
      initialNotificationTitle: 'AWESOME SERVICE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationsService.init();
  DioHelper.init();
  await CashHelper.init();
  await initializeService();

  runApp(const MyApp());
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
        textTheme: const TextTheme(
          bodyText1: TextStyle(fontSize: 15.0, color: Colors.black),
          bodyText2: TextStyle(fontSize: 17.0, color: Colors.white),
        ),
      ),
      home: CashHelper.getUserToken() != null
          ? const HomeScreen()
          : const LoginScreen(),
    );
  }
}
