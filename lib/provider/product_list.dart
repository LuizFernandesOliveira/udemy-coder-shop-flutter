import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/data/dummy_data.dart';

import '../models/product.dart';

class ProductList with ChangeNotifier {
  final _baseUrl = 'https://app-shopping-7873a-default-rtdb.firebaseio.com';
  final List<Product> _items = dummyProducts;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;
    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return add(product);
    }
  }

  Future<void> updateProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }

    return Future.value();
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }

  Future<void> add(Product product) {
    final future = http.post(Uri.parse('$_baseUrl/products.json'),
        body: jsonEncode({
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        }));

    return future.then<void>((response) {
      final id = jsonDecode(response.body)['name'];
      _items.add(Product(
        id: id,
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        isFavorite: product.isFavorite,
      ));
      notifyListeners();
    });
  }
}

// bool _showFavoriteOnly = false;
//
// List<Product> get items {
//   if (_showFavoriteOnly) {
//     return _items.where((product) => product.isFavorite).toList();
//   }
//   return [..._items];
// }
//
// void showFavoriteOnly() {
//   _showFavoriteOnly = true;
//   notifyListeners();
// }
//
// void showAll() {
//   _showFavoriteOnly = false;
//   notifyListeners();
// }
