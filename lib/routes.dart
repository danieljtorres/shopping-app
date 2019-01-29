import 'package:flutter/material.dart';
import 'package:shopping/src/ui/_index.dart';

class Routes {
  static final list = <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    '/Products': (BuildContext context) => Products(),
  };
}