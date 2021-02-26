import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';
import 'package:server_app_delivery/application/database/i_database_connection.dart';
import 'package:server_app_delivery/application/errors/database_error.dart';
import 'package:server_app_delivery/entities/menu_item.dart';
import 'package:server_app_delivery/entities/order.dart';
import 'package:server_app_delivery/entities/order_item.dart';
import 'package:server_app_delivery/modules/orders/view_models/save_order_input_model.dart';

import 'i_orders_repository.dart';

@LazySingleton(as: IOrdersRepository)
class OrdersInterface implements IOrdersRepository {
  final IDatabaseConnection _connection;

  OrdersInterface(this._connection);

  @override
  Future<void> saveOrder(SaveOrderInputModel inputOrderModel) async {
    final conn = await _connection.openConnection();
    try {
      await conn.transaction(
        (_) async {
          final resultOrder = await conn.query(
            '''
        insert into pedido(
          id_usuario,
          forma_pagamento,
          endereco_entrega
        ) 
        values(
           ?,?,?
        )
        ''',
            [
              inputOrderModel.userId,
              inputOrderModel.paymentType,
              inputOrderModel.address
            ],
          );
          final orderId = resultOrder.insertId;

          await conn.queryMulti('''
          insert into pedido_item(
            id_pedido,
            id_cardapio_grupo_item

          ) values(?,?)
          
          ''', inputOrderModel.itemsId.map((item) => [orderId, item]));
        },
      );
    } on MySqlException catch (e) {
      print(e);
      throw DatabaseError(message: 'Erro ao inserir order');
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<List<Order>> findMyOrders(int userId) async {
    try {
      final conn = await _connection.openConnection();

      List<Order> orders = [];

      final ordersResult = await conn.query('''
      select * from pedido where id_usuario = ?
      ''', [userId]);
      if (ordersResult.isNotEmpty) {
        for (var oneOrder in ordersResult) {
          final orderdata = oneOrder.fields;
          final orderItemsResult = await conn.query('''
          select 
          p.id_pedido_item, item.id_cardapio_grupo_item, item.nome, item.valor
          from pedido_item p
          inner join cardapio_grupo_item item on item.id_cardapio_grupo_item = p.id_cardapio_grupo_item
          where p.id_pedido = ?
          ''', [orderdata['id_pedido']]);
          final items = orderItemsResult.map<OrderItem>((item) {
            final itemFields = item.fields;
            return OrderItem(
              id: itemFields['id_pedido_item'],
              item: MenuItem(
                id: itemFields['id_pedido_item'],
                name: itemFields['nome'],
                price: itemFields['valor'],
              ),
            );
          }).toList();
          final order = Order(
              id: orderdata['id_pedido'] as int,
              address: (orderdata['endereco_entrega'] as Blob).toString(),
              paymentType: orderdata['forma_pagamento'],
              items: items);
          orders.add(order);
        }
      }
      return orders;
    } on MySqlException catch (e) {
      print(e);
      throw DatabaseError(message: 'Erro ao buscar orders');
    }
  }
}
