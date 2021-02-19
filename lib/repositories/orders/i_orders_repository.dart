import 'package:server_app_delivery/modules/orders/view_models/save_order_input_model.dart';

abstract class IOrdersRepository {
  Future<void> saveOrder(SaveOrderInputModel inputOrderModel);
}
