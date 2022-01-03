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
}
