import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';
import 'package:server_app_delivery/application/database/i_database_connection.dart';
import 'package:server_app_delivery/application/errors/database_error.dart';
import 'package:server_app_delivery/application/errors/user_notfound_exception.dart';
import 'package:server_app_delivery/entities/user.dart';
import 'package:server_app_delivery/modules/users/view_models/register_input_model.dart';
import 'package:server_app_delivery/modules/users/view_models/user_login_model.dart';
import 'package:server_app_delivery/repositories/user/i_user_repository.dart';

@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  final IDatabaseConnection _connection;

  UserRepository(this._connection);

  @override
  Future<void> saveUser(RegisterInputModel inputModel) async {
    final connect = await _connection.openConnection();
    try {
      await connect
          .query('insert into usuario(nome,email,senha) values(?,?,?)', [
        inputModel.name,
        inputModel.email,
        inputModel.password,
      ]);
    } on MySqlException catch (e) {
      if (e.errorNumber == 1062) {
        throw DatabaseError(message: 'Email ja se encontra cadastrado');
      }

      throw DatabaseError(message: 'Erro no cadastro');
    } finally {
      await connect?.close();
    }
  }

  @override
  Future<User> login(UserLoginModel viewModel) async {
    final connect = await _connection.openConnection();
    try {
      final result = await connect.query('''  
          select *
          from usuario
          where email = ?
          and senha = ?
          ''', [
        viewModel.email,
        viewModel.password,
      ]);
      if (result.isEmpty) {
        throw UserNotFoundException();
      }
      final row = result.first;
      return User(
        id: row['id_usuario'] as int,
        name: row['nome'] as String,
        email: row['email'] as String,
        password: row['senha'] as String,
      );
    } on MySqlException catch (e) {
      print(e);
      throw DatabaseError(message: 'Erro ao buscar usuario');
    } finally {
      await connect?.close();
    }
  }
}
