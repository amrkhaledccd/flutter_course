import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  final String? _authToken;
  final String? _userId;

  Products(this._authToken, this._userId, this._items);

  Future<void> fetchProducts([bool isFilterByUser = false]) async {
    final filterBy =
        isFilterByUser ? 'orderBy="creatorId"&equalTo="$_userId"' : '';

    final baseURL =
        "https://flutter-shop-21b26-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$_authToken&$filterBy";
    try {
      final response = await http.get(Uri.parse(baseURL));
      final Map<String, dynamic> extractedData = json.decode(response.body);

      final favoriteUrl =
          "https://flutter-shop-21b26-default-rtdb.europe-west1.firebasedatabase.app/user_favorites/$_userId.json?auth=$_authToken";

      final favoriteResponse = await http.get(Uri.parse(favoriteUrl));
      final favoriteData = json.decode(favoriteResponse.body);

      List<Product> loadedProducts = [];
      extractedData.forEach(
        (prodId, prodData) => loadedProducts.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavorite:
                favoriteData == null ? false : favoriteData[prodId] ?? false,
          ),
        ),
      );
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> addProduct(
    String title,
    String description,
    double price,
    String imageUrl,
  ) async {
    final baseURL =
        "https://flutter-shop-21b26-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$_authToken";

    try {
      final response = await http.post(Uri.parse(baseURL),
          body: json.encode({
            'title': title,
            'description': description,
            'price': price,
            'imageUrl': imageUrl,
            'creatorId': _userId,
          }));
      _items.add(Product(
        id: json.decode(response.body)['name'],
        title: title,
        description: description,
        price: price,
        imageUrl: imageUrl,
      ));
      notifyListeners();
    } catch (e) {
      print('Something went wrong');
      throw e;
    }
  }

  Future<void> editProduct(String id, String title, String description,
      double price, String imageUrl) async {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index != -1) {
      final baseURL =
          "https://flutter-shop-21b26-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=$_authToken";

      await http.patch(
        Uri.parse(baseURL),
        body: json.encode({
          'title': title,
          'description': description,
          'price': price,
          'imageUrl': imageUrl
        }),
      );

      _items[index] = Product(
          id: id,
          title: title,
          description: description,
          price: price,
          imageUrl: imageUrl);
      notifyListeners();
    }
  }

  Future<void> removeProduct(String id) async {
    final baseURL =
        "https://flutter-shop-21b26-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=$_authToken";

    var response = await http.delete(Uri.parse(baseURL));

    if (response.statusCode >= 400) {
      throw HttpException('Failed to delete product [id: $id]');
    }

    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
