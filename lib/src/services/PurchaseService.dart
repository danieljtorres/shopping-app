import 'package:shopping/src/models/PurchaseModel.dart';
import 'package:shopping/src/services/Database.dart';

class PurchaseService extends DBProvider {
  PurchaseService._();
  static PurchaseService fn = PurchaseService._();

  Future<List<Purchase>> getAll() async {
    final db = await database;
    var res = await db.query("Purchase");
    List<Purchase> list = res.isNotEmpty ? res.map((p) => Purchase.fromMap(p)).toList() : [];
    return list;
  }
}