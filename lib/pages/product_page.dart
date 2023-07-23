import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/components/app_drawer.dart';
import 'package:shopping/components/product_item.dart';
import 'package:shopping/provider/product_list.dart';
import 'package:shopping/utils/app_routes.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<ProductList>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCTS_FORM);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.items.length,
            itemBuilder: (ctx, i) => Column(
              children: [
                ProductItem(product: products.items[i]),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
