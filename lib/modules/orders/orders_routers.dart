import 'package:get_it/get_it.dart';
import 'package:server_app_delivery/application/router/i_router_configure.dart';
import 'package:server_app_delivery/modules/orders/controller/orders_controller.dart';
import 'package:shelf_router/src/router.dart';

class OrdersRouters implements IRouterConfigure {
  @override
  void configure(Router router) {
    router.mount('/orders/', GetIt.I.get<OrdersController>().router);
  }
}
