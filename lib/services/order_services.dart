import 'dart:convert';

import 'package:food_app/models/models.dart';
import 'package:food_app/models/order_item_models.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/utils/apiService.dart';

class OrderServices {
  static Future<OrderModel> fetchCurrentOrder(int id) async {
    String url = '';
    final data = await ApiService.get(url, null);
    return OrderModel.fromJson(data);
  }

  static Future<List<OrderModel>> fetchOrderList() async {
    String url = 'order';
    final data = await ApiService.get(url, null);
    print(data);
    List<OrderModel> dataList = [];
    for (var u in data['data']) {
      OrderModel orderModel = OrderModel.fromMap(u);
      dataList.add(orderModel);
    }
    return dataList;
  }

  static Future<List<OrderModel>?> fetchOrderPreparingList(int? status) async {
    try {
      String url = 'get-order';
      final data = await ApiService.get(url, {'status': status});
      print(data);
      List<OrderModel> dataList = [];
      for (var u in data['data']) {
        OrderModel orderModel = OrderModel.fromMap(u);
        dataList.add(orderModel);
      }
      return dataList;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<OrderModel> fetchOrderDetail(int id) async {
    String url = 'order/$id';
    final res = await ApiService.get(url, null);
    final data = res['data'];
    final json = jsonEncode(data);
    List<Map<dynamic, dynamic>> orderItems = [];
    for (var item in data['items']) {
      Map<dynamic, dynamic> orderItem = {};
      orderItem['item'] = item;
      orderItem['quantity'] = item['quantity'];
      orderItems.add(orderItem);
    }
    data['orderItems'] = orderItems;

    final a = OrderModel.fromMap(data);
    return a;
  }

  static Future<dynamic> createOrder(dynamic id, List<OrderItem> itemList,
      String address, int paymentmethod) async {
    try {
      String url = 'order';
      List<Map<dynamic, dynamic>> list = [];
      for (var item in itemList) {
        Map<dynamic, dynamic> orderItem = {};
        orderItem['id'] = item.item.id;
        orderItem['dish_name'] = item.item.name;
        orderItem['price'] = item.item.price;
        orderItem['desc'] = item.item.description;
        orderItem['image'] = item.item.image;

        orderItem['quantity'] = item.quantity;
        list.add(orderItem);
      }
      // print(itemList);
      Map<dynamic, dynamic> payload = {};
      payload['merchant_id'] = id;
      payload['payment_method'] = paymentmethod;
      payload['address'] = address;
      payload['items'] = list;

      // print(payload);
      // payload
      final data = await ApiService.update(url, payload);
      print(data);
      // print(data['data']['id']);
      return data['data']['id'];
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<OrderModel?> updateOrderStatus(int id, int orderStatus) async {
    try {
      String url = 'order/$id';
      final data =
          await ApiService.update(url, {'status': orderStatus}, medthod: 'PUT');
      print(data);
      return OrderModel.fromMap(data['data']);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
