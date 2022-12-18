import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/provider/product_list.dart';

import '../components/product_grid.dart';
import '../models/product.dart';

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> loadedProducts = provider.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
      ),
      body: ProductGrid(),
    );
  }
}
