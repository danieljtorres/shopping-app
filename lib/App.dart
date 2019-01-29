import 'package:flutter/material.dart';
import 'package:shopping/routes.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hcaleniel',
      initialRoute: '/',
      routes: Routes.list,
      theme: ThemeData(
        primarySwatch: Colors.green,
        hintColor: Colors.grey[400],
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
          labelStyle: TextStyle(
            fontSize: 16.0
          ),
        ),
      )
    );
  }
}
