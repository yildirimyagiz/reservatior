abstract class Failure {
  const Failure();
  
  String get message;
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  final String message;
  
  const ServerFailure(this.message);
  
  
  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  @override
  final String message;
  
  const NetworkFailure(this.message);
  
  
  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  @override
  final String message;
  
  const CacheFailure(this.message);
  
  
  @override
  List<Object?> get props => [message];
}

class ValidationFailure extends Failure {
  @override
  final String message;
  
  const ValidationFailure(this.message);
  
  
  @override
  List<Object?> get props => [message];
}

class PermissionFailure extends Failure {
  @override
  final String message;
  
  const PermissionFailure(this.message);
  
  
  @override
  List<Object?> get props => [message];
}

class NotFoundFailure extends Failure {
  @override
  final String message;
  
  const NotFoundFailure(this.message);
  
  
  @override
  List<Object?> get props => [message];
}

class UnauthorizedFailure extends Failure {
  @override
  final String message;
  
  const UnauthorizedFailure(this.message);
  
  
  @override
  List<Object?> get props => [message];
}

class ConflictFailure extends Failure {
  @override
  final String message;
  
  const ConflictFailure(this.message);
  
  
  @override
  List<Object?> get props => [message];
}

class RateLimitFailure extends Failure {
  @override
  final String message;
  
  const RateLimitFailure(this.message);
  
  
  @override
  List<Object?> get props => [message];
}

class TimeoutFailure extends Failure {
  @override
  final String message;
  
  const TimeoutFailure(this.message);
  
  
  @override
  List<Object?> get props => [message];
}

class UnknownFailure extends Failure {
  @override
  final String message;
  
  const UnknownFailure(this.message);
  
  
  @override
  List<Object?> get props => [message];
}
