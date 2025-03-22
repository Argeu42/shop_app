import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/app_drawer.dart';
import 'package:shop_app/components/order.dart';
import 'package:shop_app/models/order_list.dart';
import 'package:shop_app/utils/app_routes.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late Future futureInstance;

  @override
  void initState() {
    super.initState();
    futureInstance =
        Provider.of<OrderList>(context, listen: false).loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    // OrderList orders = Provider.of<OrderList>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Meus Pedidos')),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: futureInstance,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('Ocorreu um erro!'));
          } else {
            return RefreshIndicator(
              onRefresh:
                  () =>
                      Provider.of<OrderList>(
                        context,
                        listen: false,
                      ).loadOrders(),
              child: Consumer<OrderList>(
                builder:
                    (ctx, orders, child) =>
                        orders.items.isEmpty
                            ? NoOrdersWidget()
                            : ListView.builder(
                              itemCount: orders.itemsCount,
                              itemBuilder:
                                  (ctx, index) =>
                                      OrderWidget(order: orders.items[index]),
                            ),
              ),
            );
          }
        },
      ),
    );
  }
}

class NoOrdersWidget extends StatelessWidget {
  const NoOrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Você ainda não fez pedidos!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.home);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              'Ir para a LOJA',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
