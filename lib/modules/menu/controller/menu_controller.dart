import 'dart:async';
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:server_app_delivery/services/menu/i_menu_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'menu_controller.g.dart';

@Injectable()
class MenuController {
  final IMenuService _service;

  MenuController(this._service);

  @Route.get('/')
  Future<Response> findAll(Request request) async {
    try {
      final menus = await _service.getAllMenus();

      return Response.ok(
          jsonEncode(menus?.map((e) => e.toMap())?.toList() ?? []));
    } catch (e) {
      print(e);
      return Response.internalServerError();
    }
  }

  Router get router => _$MenuControllerRouter(this);
}
