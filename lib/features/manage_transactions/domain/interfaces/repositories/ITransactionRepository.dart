import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionCreateModel.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';

abstract class ITransactionRepository {
  Future<Either<Error, List<TransactionModel>>> getAllTransactions();
  Future<Either<Error, List<TransactionModel>>> getTransactionById(String id);
  Future<Either<Error, List<TransactionModel>>> getTransactionsByDate(DateTime date);
  Future<Either<Error, List<TransactionModel>>> getTransactionsByCategory(String category);
  Future<Either<Error, List<TransactionModel>>> createTransactions(TransactionCreateModel transaction);
}