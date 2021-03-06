import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem(
    this.id,
    this.title,
    this.price,
    this.quantity,
  );
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get count {
    return _items.values
        .fold(0, (previousValue, product) => previousValue + product.quantity);
  }

  double get total {
    return items.values.fold(
        0,
        (previousValue, product) =>
            previousValue + product.quantity * product.price);
  }

  void addToCart(String productId, String title, double price) {
    _items.putIfAbsent(
      productId,
      () => CartItem(
        DateTime.now().toString(),
        title,
        price,
        0,
      ),
    );
    _items.update(
      productId,
      (existingValue) => CartItem(
        existingValue.id,
        existingValue.title,
        existingValue.price,
        existingValue.quantity + 1,
      ),
    );
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeOneItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    _items.update(
      productId,
      (existing) => CartItem(
        existing.id,
        existing.title,
        existing.price,
        existing.quantity - 1,
      ),
    );

    if (_items[productId]!.quantity == 0) {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
