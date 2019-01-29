import 'dart:convert';

PurchaseItem purchaseItemFromJson(String str) {
  final jsonData = json.decode(str);
  return PurchaseItem.fromMap(jsonData);
}

String purchaseItemToJson(PurchaseItem data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class PurchaseItem {
  int id;
  int idPurchase;
  int idProduct;
  double price;
  double qty;

  PurchaseItem({
    this.id,
    this.idPurchase,
    this.idProduct,
    this.price,
    this.qty,
  });

  factory PurchaseItem.fromMap(Map<String, dynamic> purchaseItem) => PurchaseItem(
        id: purchaseItem['id'],
        idPurchase: purchaseItem['idPurchase'],
        idProduct: purchaseItem['idProduct'],
        price: purchaseItem['price'],
        qty: purchaseItem['qty'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'idPurchase': idPurchase,
        'idProduct': idProduct,
        'price': price,
        'qty': qty,
      };
}
