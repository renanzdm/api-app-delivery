class DatabaseConnectionConfiguration {
  final String host;
  final String user;
  final String port;
  final String password;
  final String databaseName;

  DatabaseConnectionConfiguration(
      {this.host, this.user, this.port, this.password, this.databaseName});
}
