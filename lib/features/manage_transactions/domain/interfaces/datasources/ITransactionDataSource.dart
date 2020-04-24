import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';

abstract class ITransactionDataSource {
  Future<List<TransactionModel>> getAllTransactions();
  Future<List<TransactionModel>> getTransactionsByParams(params);
}