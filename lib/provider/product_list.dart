import 'package:flutter/material.dart';
import 'package:shopping/data/dummy_data.dart';

import '../models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = dummyProducts;

  List<Product> get items {
    return [..._items];
  }

  void add(Product product) {
    _items.add(product);
    notifyListeners();
  }
}