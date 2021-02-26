import 'package:injectable/injectable.dart';
import 'package:server_app_delivery/entities/order.dart';
import 'package:server_app_delivery/modules/orders/view_models/save_order_input_model.dart';
import 'package:server_app_delivery/repositories/orders/i_orders_repository.dart';

import './i_orders_service.dart';

@LazySingleton(as: IOrdersService)
class OrdersService implements IOrdersService {
  final IOrdersRepository _repository;

  OrdersService(this._repository);

  @override
  Future<void> saveOrder(SaveOrderInputModel inputOrderModel) async {
    await _repository.saveOrder(inputOrderModel);
  }

  @override
  Future<List<Order>> findMyOrders(int userId) async {
    return await _repository.findMyOrders(userId);
  }
}
