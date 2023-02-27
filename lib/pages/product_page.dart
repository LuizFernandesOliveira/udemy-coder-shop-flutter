import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/components/app_drawer.dart';
import 'package:shopping/provider/product_list.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar produtos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.items.length,
          itemBuilder: (ctx, i) => Text(products.items[i].name),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
