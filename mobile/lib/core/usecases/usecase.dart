import 'package:dartz/dartz.dart';
import '../error/failures.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

abstract class NoParamsUseCase<T> {
  Future<Either<Failure, T>> call();
}

class NoParams {
  const NoParams();
}
