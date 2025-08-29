import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/auth.dart';
import 'package:shop_app/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Bem Vindo, Usuário!'),
            automaticallyImplyLeading: false,
          ),
          Divider(
            thickness: 5,
            height: 5,
            color: Theme.of(context).colorScheme.secondary,
          ),
          ListTile(
            leading: Icon(Icons.shopify),
            title: Text('Loja'),
            onTap: () {
              Navigator.of(
                context,
              ).pushReplacementNamed(AppRoutes.auth_or_home);
            },
          ),
          Divider(height: 5, color: Theme.of(context).colorScheme.secondary),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Pedidos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.orders);
            },
          ),
          Divider(height: 5, color: Theme.of(context).colorScheme.secondary),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Gerenciar Produtos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.products);
            },
          ),
          Divider(height: 5, color: Theme.of(context).colorScheme.secondary),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context).pushReplacementNamed(AppRoutes.auth_or_home);
            },
          ),
        ],
      ),
    );
  }
}
