import 'package:dac/main/cubit/states.dart';
import 'package:dac/modules/home_screen/home_screen.dart';
import 'package:dac/shared/cash_helper.dart';
import 'package:dac/shared/dio_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'cubit/cubit.dart';
import '../modules/login_screen/login_screen.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:dac/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

late final FlutterLocalization localization;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  //await FirebaseMessaging.instance.requestPermission();
  //LocalNotificationService.initialize();
  localization = FlutterLocalization.instance;
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
    return BlocProvider(
      create: (context) => MainCubit(),
      child: BlocConsumer<MainCubit, MainStates>(
        listener: (context, state) {},
        builder: (context, state) {
          localization.init(
            mapLocales: [
              const MapLocale('en', AppLocal.en),
              const MapLocale('ar', AppLocal.ar),
            ],
            initLanguageCode: 'en',
          );
          var mainCubitObject = MainCubit.get(context);
          localization.onTranslatedLanguage = mainCubitObject.translateApp();
          return MaterialApp(
            localizationsDelegates: localization.localizationsDelegates,
            supportedLocales: localization.supportedLocales,
            //locale: const Locale("en", "US"),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                disabledColor: Colors.grey[600],
                primarySwatch: Colors.blue,
                fontFamily: 'Comic',
                textTheme: const TextTheme(
                  bodyText1: TextStyle(
                      fontSize: kIsWeb ? 25.0 : 15.0, color: Colors.black),
                  bodyText2: TextStyle(
                      fontSize: kIsWeb ? 30.0 : 17.0, color: Colors.white),
                  headline1: TextStyle(
                      fontSize: kIsWeb ? 30.0 : 17.0, color: Colors.blue),
                  //bodyLarge: TextStyle(fontSize: kIsWeb ? 35.0 : 15.0, color: Colors.blue),
                ),
                buttonTheme: const ButtonThemeData(height: kIsWeb ? 300 : 50)),
            home: CashHelper.getUserToken() != null
                ? HomeScreen()
                : const LoginScreen(),
          );
        },
      ),
    );
  }
}
/*
CashHelper.getUserToken() != null
          ? HomeScreen()
          : const LoginScreen(),

final FlutterLocalization localization = FlutterLocalization.instance;
            localization.init(
              mapLocales: [
                const MapLocale('ar', AppLocal.ar),
              ],
              initLanguageCode: 'en',
            );
            var mainCubitObject = MainCubit.get(context);
            localization.onTranslatedLanguage = mainCubitObject.translateApp();





            MaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale("ar", "AE"), Locale("en", "US")],
      //locale: const Locale("en", "US"),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          disabledColor: Colors.grey[600],
          primarySwatch: Colors.blue,
          fontFamily: 'Comic',
          textTheme: const TextTheme(
            bodyText1:
                TextStyle(fontSize: kIsWeb ? 25.0 : 15.0, color: Colors.black),
            bodyText2:
                TextStyle(fontSize: kIsWeb ? 30.0 : 17.0, color: Colors.white),
            headline1:
                TextStyle(fontSize: kIsWeb ? 30.0 : 17.0, color: Colors.blue),
            //bodyLarge: TextStyle(fontSize: kIsWeb ? 35.0 : 15.0, color: Colors.blue),
          ),
          buttonTheme: const ButtonThemeData(height: kIsWeb ? 300 : 50)),
      home: CashHelper.getUserToken() != null
          ? HomeScreen()
          : const LoginScreen(),
    )
*/
