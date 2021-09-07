import 'package:flutter/foundation.dart';

import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final DateTime createAt;
  final List<CartItem> cartItems;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.createAt,
      required this.cartItems});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return _orders;
  }

  void addOrder(List<CartItem> cartItems, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        createAt: DateTime.now(),
        cartItems: cartItems,
      ),
    );
    notifyListeners();
  }
}
