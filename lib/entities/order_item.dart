import 'dart:convert';

import 'package:server_app_delivery/entities/menu_item.dart';

class OrderItem {
  final int id;
  final MenuItem item;

  OrderItem({this.id, this.item});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'item': item?.toMap(),
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return OrderItem(
      id: map['id'],
      item: MenuItem.fromMap(map['item']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) =>
      OrderItem.fromMap(json.decode(source));
}
