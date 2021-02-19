import 'package:injectable/injectable.dart';
import 'package:server_app_delivery/entities/menu.dart';
import 'package:server_app_delivery/repositories/menu/i_menu_repository.dart';

import './i_menu_service.dart';

@LazySingleton(as:IMenuService)
class MenuService implements  IMenuService {
  final IMenuRepository _repository;

  MenuService(this._repository);

  @override
  Future<List<Menu>> getAllMenus() {
    return _repository.findAll();

  }

}