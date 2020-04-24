import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Exceptions.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/core/network/NetworkInfo.dart';
import 'package:platy/features/manage_transactions/data/datasources/TransactionDataSource.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';
import 'package:platy/features/manage_transactions/domain/interfaces/repositories/ITransactionRepository.dart';

class TransactionRepository implements ITransactionRepository {
  final TransactionDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TransactionRepository({ this.remoteDataSource, this.networkInfo });

  @override
  Future<Either<Failure, List<TransactionModel>>> getAllTransactions() async {
      try {
        await connection();

        final remoteTransactions = await remoteDataSource.getAllTransactions();
        return Right(remoteTransactions);

      } on ServerException {
        return Left(ServerFailure());
      }
  }

  @override
  Future<Either<Failure, List<TransactionModel>>> getTransactionById(String id) async {
      try {
        await connection();

        Map<String, String> params = { '_id' : id };
        final remoteTransactions = await remoteDataSource.getTransactionsByParams(params);
        return Right(remoteTransactions);

      } on ServerException {
        return Left(ServerFailure());
      }
  }

  @override
  Future<Either<Failure, List<TransactionModel>>> getTransactionsByCategory(String category) async {
    try {
      await connection();

      Map<String, String> params = { 'category' : category };
      final remoteTransactions = await remoteDataSource.getTransactionsByParams(params);
      return Right(remoteTransactions);

    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<TransactionModel>>> getTransactionsByDate(DateTime date) async {
    try {
      await connection();

      Map<String, String> params = { 'date' : date.toString() };
      final remoteTransactions = await remoteDataSource.getTransactionsByParams(params);
      return Right(remoteTransactions);

    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<void> connection() async {
    var connected = await networkInfo.isConnected;
    if(!connected){
      throw ServerException();
    }
  }

}