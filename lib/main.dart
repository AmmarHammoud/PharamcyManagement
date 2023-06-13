import 'package:dac/modules/home_screen/home_screen.dart';
import 'package:dac/shared/cash_helper.dart';
import 'package:dac/shared/dio_helper.dart';
import 'package:flutter/material.dart';
import 'modules/login_screen/login_screen.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CashHelper.init();
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
