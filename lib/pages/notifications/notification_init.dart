import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_app/providers/notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationInit extends StatefulWidget {
  Widget child;
  NotificationInit({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _NotificationInitState createState() => _NotificationInitState();
}

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

late AndroidNotificationChannel channel;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class _NotificationInitState extends State<NotificationInit> {
  String? _token;
  late FirebaseMessaging messaging;

  setupNotificiation() async {
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      Future.delayed(Duration.zero, () async {
        //your async 'await' codes goes here
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('device_token', value!);
      });
    });

    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'Food App Order Notification', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSetttings = new InitializationSettings(android: android);
    flutterLocalNotificationsPlugin.initialize(initSetttings);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onBackgroundMessage(_messageHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print(message);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null) {
        Provider.of<NotificationProvider>(context, listen: false)
            .setCurrentNotification(notification);
      }
      // print(android);
      if (notification != null && android != null) {
        // print(notification.body);

        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,

                // icon: android.smallIcon,
                // other properties...
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupNotificiation();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
