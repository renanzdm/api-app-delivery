import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';
import 'package:server_app_delivery/application/database/i_database_connection.dart';
import 'package:server_app_delivery/application/errors/database_error.dart';
import 'package:server_app_delivery/entities/menu.dart';
import 'package:server_app_delivery/entities/menu_item.dart';

import './i_menu_repository.dart';

@LazySingleton(as: IMenuRepository)
class MenuRepository implements IMenuRepository {
  final IDatabaseConnection _connection;

  MenuRepository(this._connection);
  @override
  Future<List<Menu>> findAll() async {
    final conn = await _connection.openConnection();
    try {
      final result = await conn.query('select * from cardapio_grupo');
      if (result.isNotEmpty) {
        final menus = result
            .map<Menu>(
              (menu) => Menu(
                  id: menu['id_cardapio_grupo'] as int,
                  name: menu['nome_grupo'] as String),
            )
            .toList();
        for (var menu in menus) {
          final resultItems = await conn.query(
              'select * from cardapio_grupo_item where id_cardapio_grupo = ?',
              [menu.id]);
          if (resultItems.isNotEmpty) {
            final items = resultItems
                .map((item) => MenuItem(
                    id: item['id_cardapio_grupo_item'] as int,
                    name: item['nome'] as String,
                    price: item['valor'] as double))
                .toList();

            menu.items = items;
          }
        }
        return menus;
      }
      return [];
    } on MySqlException catch (e) {
      print(e);
      throw DatabaseError();
    } finally {
      await conn?.close();
    }
  }
}
