import 'package:flutter/material.dart';
import 'package:shopping/src/widgets/ShoppingScaffold.dart';
import 'package:shopping/src/services/_index.dart';
import 'package:shopping/src/models/_index.dart';
import 'dart:math';
import 'dart:io';
import 'ProductInsert.dart';
import 'ProductDetail.dart';

class Products extends StatefulWidget {
  Products() : super();

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> _refresh() async {
    return setState(() { });
  }

  void _addProduct() async {
    final product = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ProductInsert();
        },
        fullscreenDialog: true
      )
    );

    if (product is Product) {
      setState(() { });
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Producto Guardado!')));
    } else {
       _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Hubo un error!')));
    }
  }

  void _toProductDetail(int id) async {
    Product product = await ProductService.fn.getProduct(id);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ProductDetail(product: product);
        },
        fullscreenDialog: true
      )
    );
  }

  void _deleteProduct(int id) async {
    int res = await ProductService.fn.delete(id);
    if (res == 1) {
      setState(() { });
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Producto Eliminado!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShoppingScaffold(
      myKey: _scaffoldKey,
      title: 'Productos',
      body: _productList(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addProduct,
        elevation: 1,
      ),
    );
  }

  Widget _productList(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: FutureBuilder<List<Product>>(
            future: ProductService.fn.getAll(),
            builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {

                return CircularProgressIndicator( backgroundColor: Colors.green);

              } else if (snapshot.connectionState == ConnectionState.done) {

                if (snapshot.data.length > 0) {

                  return RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: _refresh,
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Product item = snapshot.data[index];
                        return _productItem(context, item);
                      },
                    )
                  );

                } else {

                  return RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: _refresh,
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'No hay resultados',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                        )
                      )
                    )
                  );

                }
              }
            }
          )
        ),
        Container(
          height: 45,
        )
      ]
    );
  }

  Widget _productItem(BuildContext context, Product item) {
    return Center(
      child: GestureDetector(
        onTap: () => _toProductDetail(item.id),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Dismissible(
              key: Key(item.id.toString() + Random().nextInt(10000).toString()),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.2,
                      color: Colors.green
                    )
                  )
                ),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: Builder(
                      builder: (BuildContext context) {
                        if (item.image == 'images/no-image.jpg') {
                          return Image.asset(item.image,
                            height: 50,
                            fit: BoxFit.contain,
                          );
                        } else if (item.image == null) {
                          return Image.asset('images/no-image.jpg',
                            height: 50,
                            fit: BoxFit.contain,
                          );
                        }

                        return Hero(
                          tag: item.image,
                            child: Image.file(File(item.image),
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                    )
                  ),
                  title: Text(item.name + ' (#' + item.id.toString() + ')',
                    textScaleFactor: 1, 
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      color: Colors.blueGrey
                    )
                  ),
                  subtitle: Text(item.description),
                  dense: true,
                ),
              ),
              background: Container(color: Colors.green),
              secondaryBackground: Container(
                child: Icon(Icons.delete,
                  color: Colors.white,
                  size: 40
                ),
                color: Colors.red,
                alignment: Alignment.centerRight,
              ),
              onDismissed: (DismissDirection direction) {
                if (direction == DismissDirection.endToStart) {
                  return _deleteProduct(item.id);
                }
                setState(() { });
              }
            )
          ]
        ),
      ) 
    );
  }
}
      