import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    // required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(product.imageUrl, fit: BoxFit.cover, alignment: Alignment.topCenter,),
            ),
            SizedBox(height: 10),
            Text(
              "R\$ ${product.price}",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(product.description, textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    );
  }
}
