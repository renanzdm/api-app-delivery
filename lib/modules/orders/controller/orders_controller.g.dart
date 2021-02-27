// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$OrdersControllerRouter(OrdersController service) {
  final router = Router();
  router.add('POST', r'/', service.saveOrder);
  router.add('GET', r'/user/<userId>', service.find);
  return router;
}
