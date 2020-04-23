import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Exceptions.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/core/network/NetworkInfo.dart';
import 'package:platy/features/manage_transactions/data/datasources/TransactionDataSource.dart';
import 'package:platy/features/manage_transactions/domain/entities/Transaction.dart';
import 'package:platy/features/manage_transactions/domain/interfaces/repositories/ITransactionRepository.dart';

class TransactionRepository implements ITransactionRepository {
  final TransactionDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TransactionRepository({ this.remoteDataSource, this.networkInfo });

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions(params) async {
    if(await networkInfo.isConnected){
      try {
        final remoteTransactions = await remoteDataSource.getTransactions(params);
        return Right(remoteTransactions);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

}