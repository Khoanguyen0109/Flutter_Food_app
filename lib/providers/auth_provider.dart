import 'package:flutter/material.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  late User _user;

  void setUser(User user) {
    _user = user;
  }

  get getUser {
    return _user;
  }
}
