import 'package:shopping/src/models/PurchaseItemModel.dart';
import 'package:shopping/src/services/Database.dart';

class PurchaseItemService extends DBProvider {
  PurchaseItemService._();
  static PurchaseItemService fn = PurchaseItemService._();

  Future<List<PurchaseItem>> getAll() async {
    final db = await database;
    var res = await db.query("PurchaseItem");
    List<PurchaseItem> list = res.isNotEmpty ? res.map((p) => PurchaseItem.fromMap(p)).toList() : [];
    return list;
  }
}