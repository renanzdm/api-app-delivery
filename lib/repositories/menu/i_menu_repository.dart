import 'package:server_app_delivery/entities/menu.dart';

abstract class IMenuRepository {
  Future<List<Menu>> findAll();
}
