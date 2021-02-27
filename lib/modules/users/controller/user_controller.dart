import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:server_app_delivery/application/errors/database_error.dart';
import 'package:server_app_delivery/application/errors/user_notfound_exception.dart';
import 'package:server_app_delivery/modules/users/controller/mappers/register_input_model_mapper.dart';
import 'package:server_app_delivery/modules/users/controller/mappers/user_logion_model_mapper.dart';
import 'package:server_app_delivery/services/user/i_user_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'user_controller.g.dart';

@Injectable()
class UserController {
  final IUserService _service;

  UserController(this._service);

  @Route.post('/')
  Future<Response> register(Request request) async {
    try {
      final requestMap = jsonDecode(await request.readAsString());
      final inputModel = RegisterInputModelMapper(requestMap).mapper();
      await _service.register(inputModel);
      return Response.ok(jsonEncode({'message': 'Usuario criado com sucesso'}));
    } on DatabaseError catch (e) {
      print(e.message);
      return Response.internalServerError(
          body: jsonEncode({'message': '${e.message}'}));
    } catch (e) {
      return Response.internalServerError(
          body: jsonEncode({'message': 'Erro ao registrar usuario'}));
    }
  }

  @Route.post('/auth')
  Future<Response> login(Request request) async {
    try {
      final requestMap = jsonDecode(await request.readAsString());
      final viewModel = UserLoginModelMapper(requestMap).mapper();
      final user = await _service.login(viewModel);

      return Response.ok(
        jsonEncode({
          'id': user.id,
          'email': user.email,
          'name': user.name,
        }),
      );
    } on UserNotFoundException catch (e) {
      print(e);
      return Response.forbidden('');
    } catch (e) {
      return Response.internalServerError(
          body: jsonEncode({'message': 'erro interno'}));
    }
  }

  Router get router => _$UserControllerRouter(this);
}
