import 'package:flutter/material.dart';
import 'package:shop_app/components/app_drawer.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
      ),
      drawer: AppDrawer(),
    );
  }
}