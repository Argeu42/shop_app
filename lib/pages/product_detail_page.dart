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
      // appBar: AppBar(title: Text(product.name)),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.name),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: product.id,
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0, 0.8),
                        end: Alignment(0, 0),
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.6),
                          Color.fromRGBO(0, 0, 0, 0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10),
              Text(
                "R\$ ${product.price}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(product.description, textAlign: TextAlign.center),
              ),
              SizedBox(height: 1000),
              Text('Fim', textAlign: TextAlign.center),
            ]),
          ),
        ],
      ),
    );
  }
}
