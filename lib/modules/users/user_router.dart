import 'package:get_it/get_it.dart';
import 'package:server_app_delivery/application/router/i_router_configure.dart';
import 'package:shelf_router/src/router.dart';

import 'controller/user_controller.dart';

class UserRouter implements IRouterConfigure {
  @override
  void configure(Router router) {
    final userController = GetIt.I.get<UserController>();
    router.mount('/user/', userController.router);
  }
}
