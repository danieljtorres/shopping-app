import 'package:flutter/material.dart';
import 'package:shopping/src/widgets/ShoppingScaffold.dart';

import 'package:shopping/src/models/_index.dart';
import 'package:shopping/src/services/_index.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> _wantExit() {
    return showDialog(
          context: context,
          builder: (BuildContext buildContext) {
            return new AlertDialog(
              title: new Text('Quiere salir de la aplicacion?'),
              content: new Text('No nos gusta ver que te vayas...'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('No'),
                ),
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('Si'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: ShoppingScaffold(
        title: 'Bienvenidos',
        body: _purchaseList(context),
      ),
      onWillPop: () => _wantExit(),
    );
  }

  Widget _purchaseList(BuildContext context) {
    return FutureBuilder<List<Purchase>>(
      future: PurchaseService.fn.getAll(),
      builder: (BuildContext context, AsyncSnapshot<List<Purchase>> snapshot) {
        if (snapshot.hasData && snapshot.data.length > 0) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Purchase item = snapshot.data[index];
              return _purchaseItem(context, item);
            },
          );
        } else {
          return Center(
            child: RichText(
              text: TextSpan(
                text: 'No hay resultados',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _purchaseItem(BuildContext context, Purchase item) {
    return Center(
      child: GestureDetector(
        onTap: () {
          print(item);
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.account_balance_wallet),
                title: Text(item.date),
                subtitle: Text('Compra ' + item.id.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
