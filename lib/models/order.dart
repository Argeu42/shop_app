import 'package:shop_app/models/cart_item.dart';

class Order {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime dateOrder;


  Order({
    required this.id,
    required this.total,
    required this.products,
    required this.dateOrder,
  });
}