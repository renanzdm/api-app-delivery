import 'dart:async';
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:server_app_delivery/modules/orders/controller/mapper/save_order_input_model_mapper.dart';
import 'package:server_app_delivery/services/orders/orders_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'orders_controller.g.dart';

@Injectable()
class OrdersController {
  final OrdersService _service;

  OrdersController(this._service);

  @Route.post('/')
  Future<Response> saveOrder(Request request) async {
    final inputModel = _service.saveOrder(SaveOrderInputModelMapper(request));

    return Response.ok(jsonEncode(''));
  }

  Router get router => _$OrdersControllerRouter(this);
}
