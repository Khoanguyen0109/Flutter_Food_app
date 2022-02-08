import 'package:food_app/models/models.dart';
import 'package:food_app/models/order_item_models.dart';
import 'package:food_app/models/order_model.dart';
import 'package:food_app/utils/apiService.dart';

class OrderServices {
  static String api = '';

  static Future<OrderModel> fetchCurrentOrder(int id) async {
    String url = '';
    final data = await ApiService.get(url, null);
    return OrderModel.fromJson(data);
  }

  static Future<List<OrderModel>> fetchOrderList(int id, int? status) async {
    String url = '';

    final data = await ApiService.get(url, null);
    return [OrderModel.fromJson(data)];
  }

  static Future<OrderModel> fetchOrderDetail(int id) async {
    String url = '';
    final data = await ApiService.get(url, null);
    List<OrderItem> orderItems = [];
    for (var item in data['items']) {
      OrderItem orderItem =
          OrderItem(quantity: item['quantity'], item: ItemModel.fromMap(item));
      orderItems.add(orderItem);
    }
    data['orderItems'] = orderItems;
    return OrderModel.fromJson(data);
  }

  static Future<OrderModel?> createOrder(dynamic id, List<OrderItem> itemList,
      String address, int paymentmethod) async {
    try {
      String url = '';
      List<Map<dynamic, dynamic>> list = [];
      for (var item in itemList) {
        Map<dynamic, dynamic> orderItem = item.item.toMap();
        orderItem['quantity'] = item.quantity;
        list.add(orderItem);
      }
      // print(itemList);
      Map<dynamic, dynamic> payload = {};
      payload['merchant_id'] = id;
      payload['payment_method'] = paymentmethod;
      payload['address'] = address;
      payload['items'] = list;

      print(payload);
      // payload
      final data = await ApiService.update(url, payload);
      return OrderModel.fromJson(data);
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<OrderModel> updateOrderStatus(int id, int orderStatus) async {
    String url = '';
    final data = await ApiService.get(url, null);
    return OrderModel.fromJson(data);
  }
}
