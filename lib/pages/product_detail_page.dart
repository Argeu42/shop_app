import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    // required this.product, 
    super.key
  });


  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
    );
  }
}
