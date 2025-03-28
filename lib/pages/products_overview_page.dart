import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/app_drawer.dart';
import 'package:shop_app/components/badge_item.dart';
import 'package:shop_app/components/product_grid.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/models/product_list.dart';
import 'package:shop_app/utils/app_routes.dart';

enum FilterOptions { favorite, all }

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductList>(context, listen: false).loadProducts().then((
      onValue,
    ) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minha loja"),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder:
                (_) => [
                  PopupMenuItem(
                    value: FilterOptions.favorite,
                    child: Text("Somente Favoritos"),
                  ),
                  PopupMenuItem(value: FilterOptions.all, child: Text("Todos")),
                ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.cartDetail);
              },
              icon: Icon(Icons.shopping_cart),
            ),
            builder:
                (ctx, cart, child) =>
                    BadgeItem(value: cart.itemsCount.toString(), child: child!),
          ),
        ],
      ),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                onRefresh:
                    () => Provider.of<ProductList>(
                      context,
                      listen: false,
                    ).loadProducts().then((onValue) {
                      setState(() {
                        _isLoading = false;
                      });
                    }),
                child: ProductGrid(_showFavoriteOnly),
              ),
      drawer: AppDrawer(),
    );
  }
}
