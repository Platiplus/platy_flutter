import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';

abstract class ITransactionDataSource {
  Future<Either<TransactionError, List<TransactionModel>>> getAllTransactions();
  Future<Either<TransactionError, List<TransactionModel>>> getTransactionsByParams(params);
}