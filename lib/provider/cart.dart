import 'package:flutter/material.dart';
import 'package:shopping/models/cart_item.dart';
import 'package:shopping/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id,
          (existentItem) => CartItem(
                id: existentItem.id,
                productId: existentItem.productId,
                name: existentItem.name,
                quantity: existentItem.quantity,
                price: existentItem.price,
              ));
    }
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
