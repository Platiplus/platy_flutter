import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/core/interfaces/usecases/IUseCaseNoParams.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';
import 'package:platy/features/manage_transactions/domain/interfaces/repositories/ITransactionRepository.dart';

class GetAllTransactions implements IUseCaseNoParams<List<TransactionModel>>{
  final ITransactionRepository repository;

  GetAllTransactions(this.repository);

  @override
  Future<Either<Failure, List<TransactionModel>>> call() async {
    return await repository.getAllTransactions();
  }
}