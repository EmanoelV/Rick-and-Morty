abstract class Failure implements Exception {
  String get message;
}

class ServerFailure extends Failure {
  @override
  String get message => 'Server Failure';
}

class CacheFailure extends Failure {
  @override
  String get message => 'Cache Failure';
}
