import 'package:injectable/injectable.dart';
import 'package:mysql1/src/single_connection.dart';
import 'package:server_app_delivery/application/config/database_connection_configuration.dart';

import './i_database_connection.dart';

@Injectable(as: IDatabaseConnection)
class DatabaseConnection implements IDatabaseConnection {
  final DatabaseConnectionConfiguration databaseConnection;

  DatabaseConnection(this.databaseConnection);

  @override
  Future<MySqlConnection> openConnection() {
    return MySqlConnection.connect(ConnectionSettings(
        host: databaseConnection.host,
        port: int.parse(databaseConnection.port),
        user: databaseConnection.user,
        password: databaseConnection.password,
        db: databaseConnection.databaseName));
  }
}
