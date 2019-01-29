import 'package:flutter/material.dart';
import 'package:shopping/src/services/_index.dart';
import 'package:shopping/src/models/_index.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProductInsert extends StatefulWidget {
  ProductInsert() : super();

  @override
  _ProductInsertState createState() => _ProductInsertState();
}

class _ProductInsertState extends State<ProductInsert> {
  final _formKey = GlobalKey<FormState>();
  final Product _product = Product();
  Future<File> _imageFile;

  final Map<String, String> _itemsMeasure = {
    'Unidad': 'unit',
    'Kilos': 'kg',
    'Litros': 'lt'
    };

  void _insertProduct() async {
    _formKey.currentState.save();
    await ProductService.fn.insert(_product);
    Navigator.pop(context, _product);
  }

  void _selectMeasure(String val) {
    _product.measure = val;
    setState(() { });
  }

  void _takeImage(ImageSource source) async {
    _imageFile = ImagePicker.pickImage(source: source);
    _imageFile.then((file) {
      _product.image = file.path;
    });
    print(_product.image);
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo producto'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: _insertForm(),
        ),
      ),
    );
  }

  Widget _insertForm() {

    final Widget imageInput = _imageLoader();
    
    final Widget nameInput = TextFormField(
        decoration: InputDecoration(
          labelText: 'Nombre',
        ),
        onSaved: (value) => _product.name = value,
      );

    final Widget descriptionInput = TextFormField(
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: 'Descripción',
        ),
        onSaved: (value) => _product.description = value,
      );

    final Widget divider = Divider(color: Colors.white,);

    final Widget selectMeasure = DropdownButtonFormField(
        value: _product.measure,
        items: _itemsMeasure.keys.map((String key) {
          return DropdownMenuItem(
            child: Text(key),
            value: _itemsMeasure[key],
          );
        }).toList(),
        hint: Text('Medido en:'),
        onChanged: _selectMeasure,
      );

    final Widget submitButton = SizedBox(
        child: RaisedButton(
          child: Text('Guardar', textScaleFactor: 1.2),
          color: Colors.green[400],
          textColor: Colors.white,
          elevation: 1,
          onPressed: _insertProduct,
        ),
        width: double.infinity,
        height: 50.0,
      );

    Widget layoutForm;

    Orientation orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.portrait) {
      layoutForm = Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: imageInput,
          ),
          divider,
          nameInput,
          divider,
          descriptionInput,
          divider,
          selectMeasure,
          divider,
          submitButton
        ],
      );
    } else {
      layoutForm = Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: imageInput,
                  padding: EdgeInsets.only(right: 12),
                ),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    nameInput,
                    divider,
                    descriptionInput,
                    divider,
                    selectMeasure,
                    divider,
                  ],
                ),
              ),
            ]
          ),
          divider,
          submitButton
        ]
      );
    }

    return layoutForm;
  }

  Widget _imageLoader() {
    return FutureBuilder<File>(
      future: _imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        print(snapshot.connectionState);
        if (snapshot.connectionState == ConnectionState.waiting) {
            return AspectRatio(
              aspectRatio: 0.5,
              child: CircularProgressIndicator(),
            );
        } else if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
          return GestureDetector(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.file(snapshot.data,
                  alignment: Alignment.center,
                  fit: BoxFit.cover
                ),
              ),
            ),
            onTap: () => _takeImage(ImageSource.camera),
          );
        } else {
          return GestureDetector(
            child: Icon(Icons.add_a_photo),
            onTap: () => _takeImage(ImageSource.camera),
          );
        }
      });
  }
}