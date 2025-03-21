import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/models/order.dart';

class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  void addOrder(Cart cart) {
    _items.insert(
      0,
      Order(
        id: Random().nextInt(1000000).toString(),
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        dateOrder: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}
