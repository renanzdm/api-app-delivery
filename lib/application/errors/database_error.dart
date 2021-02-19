class DatabaseError implements Exception{
  String message;

  DatabaseError({
    this.message,
    this.exception,
  });

  String exception;
}