import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/models/cart_item.dart';
import 'package:shop_app/models/product_list.dart';
import 'package:shop_app/utils/app_routes.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key, required this.cartItem});

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    final ProductList productsList = Provider.of<ProductList>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.productDetail,
          arguments: productsList.items.firstWhere(
            (prod) => prod.id == cartItem.productId,
          ),
        );
      },
      child: Dismissible(
        key: ValueKey(cartItem.id),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Theme.of(context).colorScheme.error,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Icon(Icons.delete_forever, color: Colors.white, size: 40),
        ),
        onDismissed: (_) {
          Provider.of<Cart>(
            context,
            listen: false,
          ).removeItem(cartItem.productId);
        },
        confirmDismiss: (_) {
          return showDialog<bool>(
            context: context,
            builder:
                (ctx) => AlertDialog(
                  title: Text('Tem certeza?'),
                  content: Text('Quer remover o item do carrinho?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text('Sim'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: Text(
                        'Não',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.titleLarge?.color,
                        ),
                      ),
                    ),
                  ],
                ),
          );
        },
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(cartItem.name),
              subtitle: Text(
                'Total: R\$ ${cartItem.price * cartItem.quantity}',
              ),
              leading: CircleAvatar(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(child: Text('${cartItem.price}')),
                ),
              ),
              trailing: Text('${cartItem.quantity}x'),
            ),
          ),
        ),
      ),
    );
  }
}
