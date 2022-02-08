import 'package:flutter/material.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/pages/auth/current_order_wrapper.dart';
import 'package:food_app/pages/home/home.dart';
import 'package:food_app/pages/home/shipper_home.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/services/auth_services.dart';
import 'package:food_app/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class AuthWrapperJwt extends StatelessWidget {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    Future<User?> _getCurrentUser() async {
      final SharedPreferences prefs = await _prefs;
      final String accessToken = (prefs.getString('access_token') ?? '');
      print('accestoken : $accessToken');
      User? res = await AuthServices.getUser(accessToken);
      // print(res.toString());
      if (res == null && accessToken != '') {
        Provider.of<AuthProvider>(context, listen: false).signOut();
      }
      return res;
    }

    return FutureBuilder(
        future: _getCurrentUser(),
        builder: (_, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final User? user = snapshot.data;
            String? role = user?.role;
            if (user != null) {
              Provider.of<AuthProvider>(context).setUser(user);
            }
            return user == null
                ? Login()
                : (role == 'shipper' ? ShipperHome() : CurrentOrderWrapper());
          } else {
            return Loading();
          }
        });
  }
}
