import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/provider/order_list.dart';
import 'package:shopping/pages/cart_page.dart';
import 'package:shopping/pages/orders_page.dart';
import 'package:shopping/pages/product_detail_page.dart';
import 'package:shopping/pages/product_form_page.dart';
import 'package:shopping/pages/product_page.dart';
import 'package:shopping/pages/products_overview_page.dart';
import 'package:shopping/provider/cart.dart';
import 'package:shopping/provider/product_list.dart';
import 'package:shopping/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductList()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => OrderList()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          colorScheme: const ColorScheme.light(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
          ),
          fontFamily: 'Lato',
        ),
        routes: {
          AppRoutes.HOME: (ctx) => ProductsOverviewPage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailPage(),
          AppRoutes.CART: (ctx) => CartPage(),
          AppRoutes.ORDERS: (ctx) => OrdersPage(),
          AppRoutes.PRODUCTS: (ctx) => ProductPage(),
          AppRoutes.PRODUCTS_FORM: (ctx) => ProductFormPage()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}