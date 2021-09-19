import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite() async {
    final baseURL =
        "https://flutter-shop-21b26-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json";

    try {
      final response = await http.patch(Uri.parse(baseURL),
          body: json.encode({
            'isFavorite': !isFavorite,
          }));

      if (response.statusCode >= 400) {
        throw HttpException('Failed to toggle favorite');
      }
      isFavorite = !isFavorite;
      notifyListeners();
    } catch (error) {
      print('error was thrown');
      throw error;
    }
  }
}
