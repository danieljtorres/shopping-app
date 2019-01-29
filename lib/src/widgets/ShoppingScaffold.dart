import 'package:flutter/material.dart';
import 'ShoppingDrawer.dart';

class ShoppingScaffold extends StatelessWidget {
  ShoppingScaffold({this.myKey, this.title, this.body, this.floatingActionButton});

  final Key myKey;
  final String title;
  final Widget body;
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: myKey,
      appBar: AppBar(
        title: Text(title),
        elevation: 1,
      ),
      body: body,
      drawer: ShoppingDrawer(),
      floatingActionButton: floatingActionButton,
    );
  }
}