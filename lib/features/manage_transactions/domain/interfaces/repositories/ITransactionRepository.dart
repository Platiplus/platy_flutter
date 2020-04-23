import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/features/manage_transactions/domain/entities/Transaction.dart';

abstract class ITransactionRepository {
  Future<Either<Failure, List<Transaction>>> getTransactions(dynamic params);
}