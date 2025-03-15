import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/data/dummy_data.dart';
import 'package:shop_app/models/order.dart';
import 'package:shop_app/utils/app_routes.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key, required this.order});

  final Order order;

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ExpansionTile(
        title: Text('Pedido nº: ${widget.order.id}'),
        leading: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Text(
            DateFormat('dd/MM/yyyy').format(widget.order.dateOrder),
            style: TextStyle(
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
        ),
        subtitle: Text('Valor: R\$${(widget.order.total).toStringAsFixed(2)}'),
        shape: const Border(),
        children: [
          Divider(
            color: Theme.of(context).colorScheme.primary,
            indent: 25,
            endIndent: 25,
          ),
          ...widget.order.products.map((products) {
            return ListTile(
              title: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.productDetail,
                    arguments: dummyProducts.firstWhere(
                      (prod) => prod.id == products.productId,
                    ),
                  );
                },
                child: Text(products.name),
              ),
              leading: CircleAvatar(
                child: Text('${products.quantity.toString()}x'),
              ),
              trailing: Text('R\$${products.quantity * products.price}'),
            );
          }),
          Padding(padding: EdgeInsets.only(bottom: 15))
        ],
      ),
    );
  }
}
