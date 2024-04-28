
import 'dart:convert';
import 'dart:io';

import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_app/controllers/LoginController.dart';
import 'package:remote_app/firebase_options.dart';
import 'package:remote_app/items/BottomNavBar.dart';
import 'package:remote_app/pages/GateFeaturesONOFF.dart';
import 'package:remote_app/pages/GatewayControlPage.dart';
import 'package:remote_app/pages/LoaderPage.dart';
import 'package:remote_app/pages/LoginPage.dart';
import 'package:remote_app/pages/NewUser.dart';
import 'package:remote_app/pages/Test.dart';
import 'package:remote_app/pages/UserInfoPage.dart';


Future<void> _messageHandler(RemoteMessage message) async {

  print('background message ${message.notification!.body}');
}

void main() async {

 DisableBatteryOptimization.showDisableAllOptimizationsSettings(
        "Enable Auto Start",
        "Follow the steps and enable the auto start of this app",
        "Your device has additional battery optimization",
"Follow the steps and disable the optimizations to allow smooth functioning of this app");

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.instance.getToken().then((value){
    print(value);
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    print("message recieved");
    print(event.notification!.body);
  });
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print('Message clicked!');
  });
  FirebaseMessaging.instance.subscribeToTopic("messaging");

  await Get.putAsync(() async => TokenService());
  String? token = await TokenService.getToken();
  String initialRoute = token != null ? '/bottombar' : '/spinner';

 // runApp(MyApp(initialRoute: initialRoute));
 runApp(MyApp(initialRoute: initialRoute));

}


class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MPTS',
      initialRoute: initialRoute,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/login',
          page: () => LoginPage(),
        ),
        GetPage(
          name: '/spinner',
          page: () => LoaderPage(),
        ),
        GetPage(
          name: '/bottombar',
          page: () => BottomNavBar(),

        ),
        GetPage(
          name: '/homePage',
          page: () => GatewayControlPage(),

        ),
        GetPage(
          name: '/featuresgateway',
          page: () => GateFeaturesONOFF(),
        ),
        GetPage(
          name: '/newuser',
          page: () => NewUser(),

        ),
        GetPage(
          name: '/userpageinfo',
          page: () => UserInfoPage(),

        ),

      ],
    );
  }
}
