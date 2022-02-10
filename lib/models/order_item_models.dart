import 'dart:convert';

import 'package:food_app/models/models.dart';

class OrderItem {
  int quantity;
  ItemModel item;

  OrderItem({
    required this.quantity,
    required this.item,
  });

  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'item': item.toMap(),
    };
  }

  factory OrderItem.fromMap(Map<dynamic, dynamic> map) {
    return OrderItem(
      quantity: map['quantity'] ?? 0,
      item: ItemModel.fromMap(map['item']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) =>
      OrderItem.fromMap(json.decode(source));
}
