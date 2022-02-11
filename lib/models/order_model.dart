import 'dart:convert';

import 'package:food_app/models/models.dart';
import 'package:food_app/models/order_item_models.dart';
import 'package:food_app/models/shipper.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/models/user_model.dart';

class OrderModel {
  dynamic id;
  String deliveryAddress;
  StoreModel storeModel;
  List<OrderItem>? orderItems;
  User user;
  double delyveryCost;
  double itemCost;
  double total;
  int paymentMethod;
  Shipper? shipper;
  int status;
  DateTime createdAt;
  OrderModel({
    required this.id,
    required this.deliveryAddress,
    required this.storeModel,
    this.orderItems,
    required this.user,
    required this.delyveryCost,
    required this.itemCost,
    required this.total,
    required this.paymentMethod,
    this.shipper,
    required this.status,
    required this.createdAt,
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
      'storeModel': storeModel.toMap(),
      'orderItems': orderItems?.map((x) => x?.toMap())?.toList(),
      'user': user.toMap(),
      'delyveryCost': delyveryCost,
      'itemCost': itemCost,
      'total': total,
      'paymentMethod': paymentMethod,
      'shipper': shipper?.toMap(),
      'status': status,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? null,
      deliveryAddress: map['address'] ?? '',
      storeModel: StoreModel.fromMap(map['merchant']),
      orderItems: map['orderItems'] != null
          ? List<OrderItem>.from(
              map['orderItems']?.map((x) => OrderItem.fromMap(x)))
          : null,
      user: User.fromMap(map['user']),
      delyveryCost: map['delivery_cost']?.toDouble() ?? 0.0,
      itemCost: map['item_cost']?.toDouble() ?? 0.0,
      total: map['total_bill']?.toDouble() ?? 0.0,
      paymentMethod: map['paymentMethod'] ?? 0,
      shipper: map['shipper'] != null ? Shipper.fromMap(map['shipper']) : null,
      status: map['status'] ?? 0,
      createdAt: DateTime.parse(map['createAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));
}
