import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionCreateModel.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionUpdateModel.dart';

abstract class ITransactionRepository {
  Future<Either<Error, List<TransactionModel>>> getAllTransactions();
  Future<Either<Error, List<TransactionModel>>> getTransactionById(String id);
  Future<Either<Error, List<TransactionModel>>> getTransactionsByDate(DateTime date);
  Future<Either<Error, List<TransactionModel>>> getTransactionsByCategory(String category);
  Future<Either<Error, List<TransactionModel>>> createTransactions(TransactionCreateModel transaction);
  Future<Either<Error, List<TransactionModel>>> updateTransaction(TransactionUpdateModel transaction);
  Future<Either<Error, List<TransactionModel>>> updateTransactions(TransactionUpdateModel transaction);
  Future<Either<Error, List<TransactionModel>>> deleteTransaction(String id);
  Future<Either<Error, List<TransactionModel>>> deleteTransactions(String id, String quotas);
}