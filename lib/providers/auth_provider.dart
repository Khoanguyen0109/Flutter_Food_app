import 'package:flutter/material.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/services/auth_services.dart';
import 'package:food_app/utils/apiService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  late User? _user;
  bool _isBackFromOrder = false;

  get getUser {
    return _user;
  }

  get checkBackFromOrder => _isBackFromOrder;

  void setUser(User user) {
    _user = user;
  }

  void signOut() async {
    _user = null;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    AuthServices.signOut();
    notifyListeners();
  }

  void backFromOrder() {
    _isBackFromOrder = true;
  }
}
