import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/core/network/NetworkInfo.dart';
import 'package:platy/features/manage_transactions/data/datasources/TransactionDataSource.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionCreateModel.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionUpdateModel.dart';
import 'package:platy/features/manage_transactions/domain/interfaces/repositories/ITransactionRepository.dart';

class TransactionRepository implements ITransactionRepository {
  final TransactionDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TransactionRepository({ this.remoteDataSource, this.networkInfo });

  @override
  Future<Either<Error, List<TransactionModel>>> getAllTransactions() async {
    if (!await connection()) return Left(NetworkError());

    final remoteTransactions = await remoteDataSource.getAllTransactions();

    return remoteTransactions;
  }

  @override
  Future<Either<Error, List<TransactionModel>>> getTransactionById(String id) async {
    if (!await connection()) return Left(NetworkError());

    Map<String, String> params = { '_id' : id };
    final remoteTransactions = await remoteDataSource.getTransactionsByParams(params);

    return remoteTransactions;
  }

  @override
  Future<Either<Error, List<TransactionModel>>> getTransactionsByCategory(String category) async {
    if (!await connection()) return Left(NetworkError());

    Map<String, String> params = { 'category' : category };
    final remoteTransactions = await remoteDataSource.getTransactionsByParams(params);

    return remoteTransactions;
  }

  @override
  Future<Either<Error, List<TransactionModel>>> getTransactionsByDate(DateTime date) async {
    if (!await connection()) return Left(NetworkError());

    var dateEnd = new DateTime(date.year, date.month + 1, 0);

    Map<String, String> params = { 'dateStart' : date.toString(), 'dateEnd': dateEnd.toString()  };
    final remoteTransactions = await remoteDataSource.getTransactionsByParams(params);

    return remoteTransactions;
  }

  @override
  Future<Either<Error, List<TransactionModel>>> createTransactions(TransactionCreateModel transaction) async {
    if (!await connection()) return Left(NetworkError());

    final remoteTransactions = await remoteDataSource.createTransactions(transaction);

    return remoteTransactions;
  }

  @override
  Future<Either<Error, List<TransactionModel>>> updateTransaction(TransactionUpdateModel transaction) async {
    if (!await connection()) return Left(NetworkError());

    final remoteTransactions = await remoteDataSource.updateTransaction(transaction);

    return remoteTransactions;
  }

  @override
  Future<Either<Error, List<TransactionModel>>> updateTransactions(TransactionUpdateModel transaction) async {
    if (!await connection()) return Left(NetworkError());

    final remoteTransactions = await remoteDataSource.updateTransactions(transaction);

    return remoteTransactions;
  }

  @override
  Future<Either<Error, List<TransactionModel>>> deleteTransaction(String id) async {
    if (!await connection()) return Left(NetworkError());

    final remoteTransactions = await remoteDataSource.deleteTransaction(id);

    return remoteTransactions;
  }

  @override
  Future<Either<Error, List<TransactionModel>>> deleteTransactions(String id, String quotas) async {
    if (!await connection()) return Left(NetworkError());

    final remoteTransactions = await remoteDataSource.deleteTransactions(id, quotas);

    return remoteTransactions;
  }

  Future<bool> connection() async {
    var connected = await networkInfo.isConnected;

    if(connected) {
      return true;
    }

    return false;
  }
}