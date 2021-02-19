import 'package:server_app_delivery/entities/menu.dart';

abstract class IMenuService {
  Future<List<Menu>> getAllMenus();

}