// /*
// import 'dart:async';
// import 'dart:convert';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:http/http.dart' as http;
//
// import 'package:clone_uber_app/src/utils/shared_pref.dart';
//
// import 'package:clone_uber_app/src/providers/client_provider.dart';
// import 'package:clone_uber_app/src/providers/driver_provider.dart';
//
// class PushNotificationsProvider {
//   FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
//   // ignore: close_sinks
//   StreamController _streamController = StreamController<Map<String, dynamic>>.broadcast();
//   Stream<Map<String,dynamic>> get message => _streamController.stream;
//
//   void initPushNotifications() async {
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification notification = message.notification;
//       AndroidNotification android = message.notification?.android;
//
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('A new onMessageOpenedApp event was published!');
//
//     });
//
//     // ON LAUNCH
//     FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) {
//       if (message != null) {
//         Map<String, dynamic> data = message.data;
//         SharedPref sharedPref = new SharedPref();
//         sharedPref.save('isNotification', 'true');
//         _streamController.sink.add(data);
//       }
//     });
//
//     // ON MESSAGE
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification notification = message.notification;
//       AndroidNotification android = message.notification?.android;
//       Map<String, dynamic> data = message.data;
//
//       print('Cuando estamos en primer plano');
//       print('OnMessage: $data');
//       _streamController.sink.add(data);
//
//     });
//
//     // ON RESUME
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('A new onMessageOpenedApp event was published!');
//       Map<String, dynamic> data = message.data;
//       print('OnResume $data');
//       _streamController.sink.add(data);
//     });
//
//   }
//
//   void saveToken(String idUser, String typeUser) async {
//     //String token = await FirebaseMessaging.instance.getAPNSToken();
//     String token = await FirebaseMessaging.instance.getToken();
//     Map<String, dynamic> data = {
//       'token': token
//     };
//
//     if (typeUser == 'client') {
//       ClientProvider clientProvider = new ClientProvider();
//       clientProvider.update(data, idUser);
//     }
//     else {
//       DriverProvider driverProvider = new DriverProvider();
//       driverProvider.update(data, idUser);
//     }
//
//   }
//
//   Future<void> sendMessage(String to, Map<String, dynamic> data, String title, String body) async {
//     await http.post(
//         'https://fcm.googleapis.com/fcm/send',
//         headers: <String, String> {
//           'Content-Type': 'application/json',
//           'Authorization': 'key=AAAAV6AeRZ4:APA91bE3ttC_lpcRwYP-FcID1bYFeApGKFs5jPVGFsnW1yI3L_0ZQvrJBkC7xPyY8_Z11-4JPp6WfmFFp1yQbv0W7gr9ltx1ZMltyYAdRJ1OfDKMjxp_8cvat1Fb9n7fGcdym4rpO4gh'
//         },
//         body: jsonEncode(
//             <String, dynamic> {
//               'notification': <String, dynamic> {
//                 'body': body,
//                 'title': title,
//               },
//               'priority': 'high',
//               'ttl': '4500s',
//               'data': data,
//               'to': to
//             }
//         )
//     );
//   }
//
//   void dispose() {
//     // ignore: unnecessary_statements
//     _streamController?.onCancel;
//   }
//
// }*/
