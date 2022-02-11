import 'package:flutter/material.dart';
import 'package:food_app/models/models.dart';
import 'package:food_app/models/order_item_models.dart';

class CartProvider extends ChangeNotifier {
  List<OrderItem> _items = [];
  int? _storeId;
  int? paymentmethod;
  int? get storeId => _storeId;
  List<OrderItem> get items => _items;
  bool get showCart {
    return _items.length > 0 ? true : false;
  }

  int get totalItem {
    int total = 0;
    _items.forEach((element) {
      total += element.quantity;
    });
    // print(_items);
    return total;
  }

  double get totalPay {
    double total = 0;
    _items.forEach((element) {
      total += element.item.price * element.quantity;
    });
    // print(_items);
    return total;
  }

  void addItem(ItemModel item, int quantity) {
    int index = _items.indexWhere((element) => element.item.id == item.id);
    if (index != -1) {
      _items[index].quantity += quantity;
    } else {
      _items.add(OrderItem(quantity: quantity, item: item));
    }
    _storeId = item.storeId;
    notifyListeners();
  }

  void updateItem(ItemModel item, int quantity) {
    int index = _items.indexWhere((element) => element.item.id == item.id);
    if (index != -1) {
      if (quantity == 0) {
        removeItem(index);
      } else {
        _items[index].quantity = quantity;
      }
    } else {}
    notifyListeners();
  }

  void addFirstItemToBasket(ItemModel item, int quantity) async {
    List<OrderItem> list = [];
    list.add(OrderItem(quantity: quantity, item: item));
    _items = list;
    _storeId = item.storeId;

    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    _storeId = null;
    notifyListeners();
  }

  void updateCart(ItemModel item) {
    notifyListeners();
  }
}
