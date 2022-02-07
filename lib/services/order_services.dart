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
    return OrderModel.fromJson(data);
  }

  static Future<OrderModel?> createOrder(
      int? id, List<OrderItem> itemList) async {
    try {
      String url = '';
      final data = await ApiService.get(url, null);
      return OrderModel.fromJson(data);
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
