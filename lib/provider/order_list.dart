import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shopping/provider/cart.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/utils/constant.dart';

import '../models/cart_item.dart';
import '../models/order.dart';

class OrderList with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    _items.clear();
    final response =
        await http.get(Uri.parse('${Constant.ORDER_BASE_URL}.json'));
    if (response.body == 'null') {
      return;
    }
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((identify, order) {
      _items.add(Order(
        id: identify,
        total: order['total'],
        products: (order['products'] as List<dynamic>).map((item) {
          return CartItem(
            id: item['id'],
            productId: item['productId'],
            name: item['name'],
            quantity: item['quantity'],
            price: item['price'],
          );
        }).toList(),
        date: DateTime.parse(order['date']),
      ));
    });

    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response =
        await http.post(Uri.parse('${Constant.ORDER_BASE_URL}.json'),
            body: jsonEncode({
              'total': cart.totalAmount,
              'date': date.toIso8601String(),
              'products': cart.items.values
                  .map((cartItem) => {
                        'id': cartItem.id,
                        'productId': cartItem.productId,
                        'name': cartItem.name,
                        'quantity': cartItem.quantity,
                        'price': cartItem.price,
                      })
                  .toList(),
            }));
    final id = jsonDecode(response.body)['name'];
    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: date,
      ),
    );
    notifyListeners();
  }
}
