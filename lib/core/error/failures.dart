abstract class Failure {
  const Failure(this.message);
  final String message;

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  @override
  String toString() => 'ServerFailure: $message';
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);

  @override
  String toString() => 'NetworkFailure: $message';
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);

  @override
  String toString() => 'CacheFailure: $message';
}
