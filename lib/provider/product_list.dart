import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopping/data/dummy_data.dart';

import '../models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  void saveProduct(Map<String, Object> data) {
    add(
        Product(
          id: Random().nextDouble().toString(),
          name: data['name'] as String,
          description: data['description'] as String,
          price: data['price'] as double,
          imageUrl: data['imageUrl'] as String,
        )
    );
  }

  void add(Product product) {
    _items.add(product);
    notifyListeners();
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