import 'package:flutter/material.dart';
import 'package:shopping/pages/products_overview_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        colorScheme: const ColorScheme.light(
          primary: Colors.purple,
          secondary: Colors.deepOrange,
        ),
        fontFamily: 'Lato',
      ),
      home: ProductsOverviewPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}