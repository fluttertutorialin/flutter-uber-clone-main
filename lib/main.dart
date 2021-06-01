import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:clone_uber_app/src/pages/home/home_page.dart';
import 'package:clone_uber_app/src/pages/login/login_page.dart';

import 'package:clone_uber_app/src/pages/client/register/client_register_page.dart';
import 'package:clone_uber_app/src/pages/client/travel_info/client_travel_info_page.dart';
import 'package:clone_uber_app/src/pages/client/map/client_map_page.dart';
import 'package:clone_uber_app/src/pages/client/travel_map/client_travel_map_page.dart';

import 'package:clone_uber_app/src/pages/driver/register/driver_register_page.dart';
import 'package:clone_uber_app/src/pages/driver/map/driver_map_page.dart';
import 'package:clone_uber_app/src/pages/driver/travel_map/driver_travel_map_page.dart';
import 'package:clone_uber_app/src/pages/driver/driver_calification/driver_travel_calification_page.dart';
import 'package:clone_uber_app/src/pages/client/travel_calification/client_travel_calification_page.dart';

import 'package:clone_uber_app/src/pages/client/travel_request/client_travel_request_page.dart';
import 'package:clone_uber_app/src/pages/driver/travel_request/driver_travel_request_page.dart';

import 'package:clone_uber_app/src/providers/push_notification_provider.dart';

import 'package:clone_uber_app/src/utils/colors.dart' as utils;

/*Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}*/

void main() async {
  //comment
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //FirebaseMessaging.onBackgroundMessage((_firebaseMessagingBackgroundHandler));

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

/*    PushNotificationsProvider pushNotificationsProvider = new PushNotificationsProvider();
    pushNotificationsProvider.initPushNotifications();

    pushNotificationsProvider.message.listen((data) {
      print('------NOTIFICACION NUEVA------');
      print(data);

      navigatorKey.currentState.pushNamed('driver/travel/request', arguments: data);
    });*/
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Uber Clone',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      theme: ThemeData(
          fontFamily: 'NimbusSans',
          appBarTheme: AppBarTheme(
              elevation: 0
          ),
          primaryColor: utils.Colors.uber_clone_color
      ),
      routes: {
        'home' : (BuildContext context) => HomePage(),
        'login': (BuildContext context) => LoginPage(),
        'client/register': (BuildContext context) => ClientRegisterPage(),
        'driver/register': (BuildContext context) => DriverRegisterPage(),
        'driver/map': (BuildContext context) => DriverMapPage(),
        'driver/travel/request': (BuildContext context) => DriverTravelRequestPage(),
        'driver/travel/map': (BuildContext context) => DriverTravelMapPage(),
        'driver/travel/calification': (BuildContext context) => DriverTravelCalificationPage(),
        'client/map': (BuildContext context) => ClientMapPage(),
        'client/travel/info': (BuildContext context) => ClientTravelInfoPage(),
        'client/travel/request': (BuildContext context) => ClientTravelRequestPage(),
        'client/travel/map': (BuildContext context) => ClientTravelMapPage(),
        'client/travel/calification': (BuildContext context) => ClientTravelCalificationPage(),

      },
    );
  }
}
