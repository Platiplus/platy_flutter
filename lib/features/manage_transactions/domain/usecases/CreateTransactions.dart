import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/core/interfaces/usecases/IUseCaseWithParams.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionCreateModel.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';
import 'package:platy/features/manage_transactions/domain/interfaces/repositories/ITransactionRepository.dart';

class CreateTransactions implements IUseCaseWithParams<List<TransactionModel>, TransactionCreateModel>{
  final ITransactionRepository repository;
  CreateTransactions(this.repository);

  @override
  Future<Either<Error, List<TransactionModel>>> call(TransactionCreateModel transaction) async {
    return await repository.createTransactions(transaction);
  }
}