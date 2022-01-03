import 'package:flutter/material.dart';
import 'package:food_app/models/models.dart';
import 'package:food_app/models/order_item_models.dart';

class CartProvider extends ChangeNotifier {
  List<OrderItem> _items = [];

  List<OrderItem> get items => _items;
  bool get showCart {
    return _items.length > 0 ? true : false;
  }

  int get totalItem {
    int total = 0;
    _items.forEach((element) {
      total += element.quantity;
    });
    print(_items);
    return total;
  }

  double get totalPay {
    double total = 0;
    _items.forEach((element) {
      total += element.totalPrice;
    });
    print(_items);
    return total;
  }

  void addItem(ItemModel item, int quantity) {
    int index = _items.indexWhere((element) => element.item.id == item.id);
    if (index != -1) {
      _items[index].quantity += quantity;
    } else {
      _items.add(OrderItem(
          quantity: quantity, item: item, totalPrice: item.price * quantity));
    }
    notifyListeners();
  }

  void updateItem(ItemModel item) {}

  void addFirstItemToBasket(ItemModel item) {
    // _items[item] = 1;
    // service.addProduct(product);
    // notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }

  void updateCart(ItemModel item) {
    notifyListeners();
  }
}
