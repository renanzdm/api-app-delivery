import 'package:server_app_delivery/application/router/i_router_configure.dart';
import 'package:server_app_delivery/modules/menu/menu_routers.dart';
import 'package:server_app_delivery/modules/orders/orders_routers.dart';
import 'package:server_app_delivery/modules/users/user_router.dart';
import 'package:shelf_router/src/router.dart';

class RouterConfigure {
  final Router _router;
  final List<IRouterConfigure> routers = [
    UserRouter(),
    MenuRouters(),
    OrdersRouters()
  ];

  RouterConfigure(this._router);

  void configure() {
    return routers.forEach((element) {
      element.configure(_router);
    });
  }
}
