import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/core/interfaces/usecases/IUseCaseWithParams.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionUpdateModel.dart';
import 'package:platy/features/manage_transactions/domain/interfaces/repositories/ITransactionRepository.dart';

class DeleteTransaction implements IUseCaseWithParams<List<TransactionModel>, String>{
  final ITransactionRepository repository;
  DeleteTransaction(this.repository);

  @override
  Future<Either<Error, List<TransactionModel>>> call(String id) async {
    return await repository.deleteTransaction(id);
  }
}