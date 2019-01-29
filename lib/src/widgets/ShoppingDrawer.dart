import 'package:flutter/material.dart';

class ShoppingDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text('Menu')
          ),
          ListTile(
            title: Text('Compras'),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
            }
          ),
          ListTile(
            title: Text('Lista de productos'),
            onTap: () { 
              Navigator.of(context).pop();
              Navigator.of(context).pushNamedAndRemoveUntil('/Products', ModalRoute.withName('/'));
            },
          )
        ],
      ),
    );
  }
}