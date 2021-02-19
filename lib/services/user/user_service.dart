import 'package:injectable/injectable.dart';
import 'package:server_app_delivery/application/helpers/Encrypt_helper.dart';
import 'package:server_app_delivery/entities/user.dart';
import 'package:server_app_delivery/modules/users/view_models/register_input_model.dart';
import 'package:server_app_delivery/modules/users/view_models/user_login_model.dart';
import 'package:server_app_delivery/repositories/user/i_user_repository.dart';
import 'package:server_app_delivery/services/user/i_user_service.dart';

@LazySingleton(as: IUserService)
class UserService implements IUserService {
  final IUserRepository _repository;

  UserService(this._repository);

  @override
  Future<void> register(RegisterInputModel inputModel) async {
    final passwordEncrypt =
        EncryptHelper.generateSHA256Hash(inputModel.password);
    inputModel.password = passwordEncrypt;

    await _repository.saveUser(inputModel);
  }

  @override
  Future<User> login(UserLoginModel viewModel) async {
    final passwordEncrypt =
        EncryptHelper.generateSHA256Hash(viewModel.password);
    viewModel.password = passwordEncrypt;
    return await _repository.login(viewModel);
  }
}
