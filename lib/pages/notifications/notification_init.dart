import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationInit extends StatefulWidget {
  Widget child;
  NotificationInit({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _NotificationInitState createState() => _NotificationInitState();
}

class _NotificationInitState extends State<NotificationInit> {
  String? _token;
  late FirebaseMessaging messaging;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      Future.delayed(Duration.zero, () async {
        // print(value);
        //your async 'await' codes goes here
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('device_token', value!);
      });
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
