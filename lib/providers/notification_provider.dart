import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  RemoteNotification? _curentNotification;

  RemoteNotification? get curentNotification => _curentNotification;
  void setCurrentNotification(notification) {
    _curentNotification = notification;
    notifyListeners();
  }
}
