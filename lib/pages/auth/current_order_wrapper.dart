import 'package:flutter/material.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/models/user_model.dart';
import 'package:food_app/pages/home/home.dart';
import 'package:food_app/pages/home/shipper_home.dart';
import 'package:food_app/pages/order/order.dart';
import 'package:food_app/providers/auth_provider.dart';
import 'package:food_app/services/auth_services.dart';
import 'package:food_app/services/order_services.dart';
import 'package:food_app/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentOrderWrapper extends StatelessWidget {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    bool _isBackFromOrder =
        Provider.of<AuthProvider>(context).checkBackFromOrder;
    Future<OrderModel?> _getCurrentOrder() async {
      try {
        User? user = Provider.of<AuthProvider>(context).getUser;

        OrderModel? res =
            await OrderServices.fetchCurrentOrder(int.parse(user!.id));
        return res;
      } catch (e) {
        return null;
      }
    }

    return FutureBuilder(
        future: _getCurrentOrder(),
        builder: (_, AsyncSnapshot<OrderModel?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final OrderModel? order = snapshot.data;
            print(_isBackFromOrder);
            return (order != null && !_isBackFromOrder)
                ? Order(orderId: order.id)
                : Home();
          } else {
            return Loading();
          }
        });
  }
}
