import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionCreateModel.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';

abstract class ITransactionDataSource {
  Future<Either<Error, List<TransactionModel>>> getAllTransactions();
  Future<Either<Error, List<TransactionModel>>> getTransactionsByParams(params);
  Future<Either<Error, List<TransactionModel>>> createTransactions(TransactionCreateModel transaction);
}