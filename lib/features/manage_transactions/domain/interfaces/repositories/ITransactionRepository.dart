import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';

abstract class ITransactionRepository {
  Future<Either<Failure, List<TransactionModel>>> getAllTransactions();
  Future<Either<Failure, List<TransactionModel>>> getTransactionById(String id);
  Future<Either<Failure, List<TransactionModel>>> getTransactionsByDate(DateTime date);
  Future<Either<Failure, List<TransactionModel>>> getTransactionsByCategory(String category);
}