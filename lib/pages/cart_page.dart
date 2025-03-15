import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/cart_item.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/models/order_list.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final itens = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(title: Text("Carrinho")),
      body: Column(
        children: [
          Card(
            elevation: 10,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 10),
                  Chip(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    side: BorderSide.none,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      'R\$${(cart.totalAmount).toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Provider.of<OrderList>(
                        context,
                        listen: false,
                      ).addOrder(cart);

                      cart.clear();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Text(
                      'Finalizar a Compra',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itens.length,
              itemBuilder:
                  (ctx, index) => CartItemWidget(cartItem: itens[index]),
            ),
          ),
        ],
      ),
    );
  }
}
