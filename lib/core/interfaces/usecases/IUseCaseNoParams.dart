import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';

abstract class IUseCaseNoParams<Type> {
  Future<Either<Error, Type>> call();
}