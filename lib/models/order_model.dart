import 'dart:convert';

import 'package:food_app/models/models.dart';
import 'package:food_app/models/order_item_models.dart';
import 'package:food_app/models/shipper.dart';

class OrderModel {
  int id;
  String deliveryAddress;
  List<OrderItem> orderItems;
  double delyveryCost;
  double itemCost;
  double total;
  int paymentMethod;
  Shipper? shipper;
  int status;
  OrderModel({
    required this.id,
    required this.deliveryAddress,
    required this.orderItems,
    required this.delyveryCost,
    required this.itemCost,
    required this.total,
    required this.paymentMethod,
    this.shipper,
    required this.status,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.id == id &&
        other.deliveryAddress == deliveryAddress &&
        other.delyveryCost == delyveryCost &&
        other.itemCost == itemCost &&
        other.total == total &&
        other.paymentMethod == paymentMethod &&
        other.shipper == shipper &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        deliveryAddress.hashCode ^
        delyveryCost.hashCode ^
        itemCost.hashCode ^
        total.hashCode ^
        paymentMethod.hashCode ^
        shipper.hashCode ^
        status.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'deliveryAddress': deliveryAddress,
      'orderItems': orderItems.map((x) => x.toMap()).toList(),
      'delyveryCost': delyveryCost,
      'itemCost': itemCost,
      'total': total,
      'paymentMethod': paymentMethod,
      'shipper': shipper?.toMap(),
      'status': status,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id']?.toInt() ?? 0,
      deliveryAddress: map['deliveryAddress'] ?? '',
      orderItems: List<OrderItem>.from(map['orderItems']?.map((x) => OrderItem.fromMap(x))),
      delyveryCost: map['delyveryCost']?.toDouble() ?? 0.0,
      itemCost: map['itemCost']?.toDouble() ?? 0.0,
      total: map['total']?.toDouble() ?? 0.0,
      paymentMethod: map['paymentMethod']?.toInt() ?? 0,
      shipper: map['shipper'] != null ? Shipper.fromMap(map['shipper']) : null,
      status: map['status']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source));
}
