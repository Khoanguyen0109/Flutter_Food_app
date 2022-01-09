import 'dart:convert';

import 'package:food_app/models/models.dart';

class OrderItem {
  int quantity;
  ItemModel item;
  double totalPrice;
  OrderItem({
    required this.quantity,
    required this.item,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'item': item.toMap(),
      'totalPrice': totalPrice,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      quantity: map['quantity']?.toInt() ?? 0,
      item: ItemModel.fromMap(map['item']),
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) =>
      OrderItem.fromMap(json.decode(source));
}
