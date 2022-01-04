import 'package:connectivity/connectivity.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:otp/controller/auth_controller.dart';
import 'package:otp/controller/connectivity_controller.dart';
import 'package:otp/controller/login_controller.dart';
import 'package:otp/db/db_services.dart';
import 'package:otp/locator.dart';
import 'package:otp/screens/login_screen.dart';
import 'package:get/get.dart';
import 'package:otp/translation.dart';

import 'screens/splach_screen.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
}

Future<void> main() async {
  setUpLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp();
  await locator<HiveServices>().init();
  await GetStorage.init();

  // var token = await FirebaseMessaging.instance.getToken();
  //print(token.toString());
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
    final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        translations: Translation(),
        locale: Locale('en'),
        fallbackLocale: Locale('en'),
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}
