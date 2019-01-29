import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  Database _database;

  Future<Database> get database async {
    if (_database != null)
    return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "shopping.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Product ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name TEXT NOT NULL,"
          "description TEXT,"
          "measure TEXT default 'unit',"
          "image TEXT default 'images/no-image.jpg'"
          ")");
      await db.execute("CREATE TABLE Purchase ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "date DATATIME"
          ")");
      await db.execute("CREATE TABLE PurchaseItem ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "idPurchase INTEGER,"
          "idProduct INTEGER,"
          "price DOUBLE,"
          "qty DOUBLE"
          ")");
    });
  }
}