import 'dart:convert';

Product productFromJson(String str) {
  final jsonData = json.decode(str);
  return Product.fromMap(jsonData);
}

String productToJson(Product data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Product {
  int id;
  String name;
  String description;
  String measure;
  String image;

  Product({this.id, this.name, this.description, this.measure, this.image});

  factory Product.fromMap(Map<String, dynamic> product) => Product(
        id: product['id'],
        name: product['name'],
        description: product['description'],
        measure: product['measure'],
        image: product['image'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'measure': measure,
        'image': image,
      };
}
