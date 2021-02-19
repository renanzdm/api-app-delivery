import 'package:server_app_delivery/entities/user.dart';
import 'package:server_app_delivery/modules/users/view_models/register_input_model.dart';
import 'package:server_app_delivery/modules/users/view_models/user_login_model.dart';

abstract class IUserService {
  Future<void> register(RegisterInputModel inputModel);

  Future<User> login(UserLoginModel viewModel);
}
