import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/core/interfaces/usecases/IUseCaseWithParams.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionUpdateModel.dart';
import 'package:platy/features/manage_transactions/domain/interfaces/repositories/ITransactionRepository.dart';

class UpdateTransactions implements IUseCaseWithParams<List<TransactionModel>, TransactionUpdateModel>{
  final ITransactionRepository repository;
  UpdateTransactions(this.repository);

  @override
  Future<Either<Error, List<TransactionModel>>> call(TransactionUpdateModel transaction) async {
    return await repository.updateTransactions(transaction);
  }
}