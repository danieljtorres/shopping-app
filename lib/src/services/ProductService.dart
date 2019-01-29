import 'package:shopping/src/models/ProductModel.dart';
import 'package:shopping/src/services/Database.dart';

class ProductService extends DBProvider {
  ProductService._();
  static ProductService fn = ProductService._();
  static String table = "Product";
  static List<String> columns = ["id", "name", "measure", "image"];

  Future<List<Product>> getAll() async {
    final db = await database;
    var res = await db.query(table);
    List<Product> list = res.isNotEmpty ? res.map((p) => Product.fromMap(p)).toList() : [];
    return list;
  }

  Future<Product> getProduct(int id) async {
    final db = await database;
    List<Map> maps = await db.query(table,
        columns: columns,
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Product.fromMap(maps.first);
    }
    return null;
  }

  Future<Product>insert(Product product) async {
    final db = await database;
    product.id = await db.insert(table, product.toMap());
    return product;
  }

  Future<int> update(Product product) async {
    final db = await database;
    return await db.update(table,
        product.toMap(),
        where: 'id = ?',
        whereArgs: [product.id]);
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(table,
        where: 'id = ?',
        whereArgs: [id]);
  }
}