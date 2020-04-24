import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';

abstract class IUseCaseWithParams<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}