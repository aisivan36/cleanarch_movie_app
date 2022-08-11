class ServerException implements Exception {}

class DatabaseException implements Exception {
  final String message;

  const DatabaseException(this.message);
}
