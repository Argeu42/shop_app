import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/models/order_list.dart';
import 'package:shop_app/models/product_list.dart';
import 'package:shop_app/pages/cart_page.dart';
import 'package:shop_app/pages/orders_page.dart';
import 'package:shop_app/pages/product_detail_page.dart';
import 'package:shop_app/pages/products_overview_page.dart';
import 'package:shop_app/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            centerTitle: true,
          ),
          colorScheme: ColorScheme.light(
            primary: Colors.purple,
            secondary: Color(0xff3ce31c),
          ),
          primaryColor: Colors.red,
          fontFamily: 'Lato',
          textTheme: TextTheme().copyWith(
            titleLarge: TextStyle(color: Colors.white),
          ),
        ),
        // home: ProductsOverviewPage(),
        routes: {
          AppRoutes.home: (ctx) => ProductsOverviewPage(),
          AppRoutes.productDetail: (ctx) => ProductDetailPage(),
          AppRoutes.cartDetail: (ctx) => CartPage(),
          AppRoutes.orders: (ctx) => OrdersPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
