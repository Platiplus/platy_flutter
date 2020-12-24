import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/core/interfaces/usecases/IUseCaseWithParams.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionUpdateModel.dart';
import 'package:platy/features/manage_transactions/domain/interfaces/repositories/ITransactionRepository.dart';

class DeleteTransactions implements IUseCaseWithParams<List<TransactionModel>, List<String>>{
  final ITransactionRepository repository;
  DeleteTransactions(this.repository);

  @override
  Future<Either<Error, List<TransactionModel>>> call(List<String> params) async {
    var id = params[0];
    var quotas = params[1];

    return await repository.deleteTransactions(id, quotas);
  }
}