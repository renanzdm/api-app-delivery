import 'package:server_app_delivery/modules/orders/view_models/save_order_input_model.dart';

abstract class IOrdersService {
  Future<void> saveOrder(SaveOrderInputModel inputOrderModel);
}
