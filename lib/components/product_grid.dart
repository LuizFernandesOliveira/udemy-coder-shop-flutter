import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/components/product_grid_item.dart';

import '../models/product.dart';
import '../provider/product_list.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;

  const ProductGrid({required this.showFavoriteOnly});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(
      context,
      listen: true,
    );

    final List<Product> loadedProducts = showFavoriteOnly
        ? provider.favoriteItems
        : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider.value(
          value: loadedProducts[index],
          child: const ProductGridItem(),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
