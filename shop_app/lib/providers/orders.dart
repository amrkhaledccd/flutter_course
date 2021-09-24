import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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
  final String? _authToken;
  final String? _userId;

  Orders(this._authToken, this._userId, this._orders);

  List<OrderItem> get orders {
    return _orders;
  }

  Future<void> fetchOrders() async {
    final baseURL =
        'https://flutter-shop-21b26-default-rtdb.europe-west1.firebasedatabase.app/orders.json?auth=$_authToken&orderBy="creatorId"&equalTo="$_userId"';
    final response = await http.get(Uri.parse(baseURL));
    final Map<String, dynamic> fetchedOrders = json.decode(response.body);
    List<OrderItem> loadedOrders = [];

    if (fetchedOrders == null) {
      return;
    }
    fetchedOrders.forEach((itemId, orderData) {
      List<CartItem> cartItems = [];

      (orderData['cartItems'] as List).forEach((item) {
        final itemMap = json.decode(item);
        cartItems.add(CartItem(
          itemMap['id'],
          itemMap['title'],
          itemMap['price'],
          itemMap['quantity'],
        ));
      });

      loadedOrders.add(
        OrderItem(
          id: itemId,
          amount: orderData['amount'],
          createAt: DateTime.parse(orderData['createdAt']),
          cartItems: cartItems,
        ),
      );
    });

    _orders = loadedOrders;
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartItems, double total) async {
    final baseURL =
        "https://flutter-shop-21b26-default-rtdb.europe-west1.firebasedatabase.app/orders.json?auth=$_authToken";

    final now = DateTime.now();

    try {
      final response = await http.post(Uri.parse(baseURL),
          body: json.encode({
            'amount': total,
            'createdAt': now.toString(),
            'creatorId': _userId,
            'cartItems': cartItems
                .map(
                  (item) => json.encode({
                    'id': item.id,
                    'title': item.title,
                    'price': item.price,
                    'quantity': item.quantity,
                  }),
                )
                .toList(),
          }));

      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          createAt: now,
          cartItems: cartItems,
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
