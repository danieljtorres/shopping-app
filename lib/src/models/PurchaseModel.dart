import 'dart:convert';

Purchase purchaseFromJson(String str) {
  final jsonData = json.decode(str);
  return Purchase.fromMap(jsonData);
}

String purchaseToJson(Purchase data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Purchase {
  int id;
  String date;

  Purchase({this.id, this.date});

  factory Purchase.fromMap(Map<String, dynamic> purchase) =>
      Purchase(id: purchase['id'], date: purchase['date']);

  Map<String, dynamic> toMap() => {'id': id, 'date': date};
}
