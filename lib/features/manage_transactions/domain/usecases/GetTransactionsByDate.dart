import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/core/interfaces/usecases/IUseCaseWithParams.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';
import 'package:platy/features/manage_transactions/domain/interfaces/repositories/ITransactionRepository.dart';

class GetTransactionsByDate implements IUseCaseWithParams<List<TransactionModel>, DateTime>{
  final ITransactionRepository repository;

  GetTransactionsByDate(this.repository);

  @override
  Future<Either<Error, List<TransactionModel>>> call(date) async {
    return await repository.getTransactionsByDate(date);
  }
}