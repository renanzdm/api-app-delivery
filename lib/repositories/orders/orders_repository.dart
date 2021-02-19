import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';
import 'package:server_app_delivery/application/database/i_database_connection.dart';
import 'package:server_app_delivery/application/errors/database_error.dart';
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
          
          ''', inputOrderModel.itemsId.map((item) => [orderId, item]).toList());
        },
      );
    } on MySqlException catch (e) {
      print(e);
      throw DatabaseError(message: 'Erro ao inserir order');
    } finally {
      await conn?.close();
    }
  }
}
