import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/core/usecases/UseCase.dart';
import 'package:platy/features/manage_transactions/domain/entities/Transaction.dart';
import 'package:platy/features/manage_transactions/domain/interfaces/repositories/ITransactionRepository.dart';

class GetTransactions implements UseCase<List<Transaction>, dynamic>{
  final ITransactionRepository repository;

  GetTransactions(this.repository);

  @override
  Future<Either<Failure, List<Transaction>>> call(params) async {
    return await repository.getTransactions(params);
  }
}