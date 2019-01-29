import 'package:flutter/material.dart';
import 'package:shopping/src/widgets/ShoppingScaffold.dart';
import 'package:shopping/src/services/_index.dart';
import 'package:shopping/src/models/_index.dart';
import 'dart:io';

class ProductDetail extends StatefulWidget {
  ProductDetail({Key key, this.product}) : super(key: key);

  final Product product;

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Hero(
                tag: widget.product.image,
                child: Image.file(File(widget.product.image),
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 30.0,
                left: 10.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  child: Container(
                    color: Colors.green,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white,),
                      onPressed: () {
                        Navigator.pop(context);
                      }
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: Colors.green,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
                Text('asasas'),
              ],
            ),
          ),
        ]
      ),
    );
  }
}