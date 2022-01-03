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
}
