import 'package:mysql1/mysql1.dart';

abstract class IDatabaseConnection {
  Future<MySqlConnection> openConnection();
}
