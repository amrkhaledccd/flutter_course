import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchProducts() async {
    final baseURL =
        "https://flutter-shop-21b26-default-rtdb.europe-west1.firebasedatabase.app/products.json";
    try {
      final response = await http.get(Uri.parse(baseURL));
      final Map<String, dynamic> extractedData = json.decode(response.body);
      List<Product> loadedProducts = [];
      extractedData.forEach(
        (prodId, prodData) => loadedProducts.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavorite: prodData['isFavorite'],
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
        "https://flutter-shop-21b26-default-rtdb.europe-west1.firebasedatabase.app/products.json";

    try {
      final response = await http.post(Uri.parse(baseURL),
          body: json.encode({
            'title': title,
            'description': description,
            'price': price,
            'imageUrl': imageUrl,
            'isFavorite': false,
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
          "https://flutter-shop-21b26-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json";

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
        "https://flutter-shop-21b26-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json";

    var response = await http.delete(Uri.parse(baseURL));

    if (response.statusCode >= 400) {
      throw HttpException('Failed to delete product [id: $id]');
    }

    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
