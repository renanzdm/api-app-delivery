import 'dart:convert';

class MenuItem {
  final int id;
  final String name;
  final double price;

  MenuItem({this.id, this.name, this.price});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MenuItem(
      id: map['id'],
      name: map['name'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuItem.fromJson(String source) =>
      MenuItem.fromMap(json.decode(source));
}
