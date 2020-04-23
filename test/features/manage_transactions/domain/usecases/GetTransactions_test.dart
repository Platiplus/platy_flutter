import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:platy/features/manage_transactions/domain/entities/Transaction.dart';
import 'package:platy/features/manage_transactions/domain/interfaces/repositories/ITransactionRepository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platy/features/manage_transactions/domain/usecases/GetTransactions.dart';

class MockTransactionRepository extends Mock implements ITransactionRepository {

}

void main(){
  GetTransactions usecase;
  MockTransactionRepository mockTransactionRepository;

  setUp(() {
    mockTransactionRepository = MockTransactionRepository();
    usecase = GetTransactions(mockTransactionRepository);
  });

  final tTransactions = new List<Transaction>();
  tTransactions.add(new Transaction(
      id: 'newID',
      type: 1,
      value: 100.25,
      description: 'Testing Description',
      date: new DateTime(2020, 3, 1),
      target: 'Target',
      category: 'Category Description',
      status: true,
      quotas: 'unique',
      owner: 'ownerID',
      account: 'accountID'
  ));

  test(
    'should get transactions within a specific month',
      () async {
        //arrange
        when(mockTransactionRepository.getTransactions(any))
            .thenAnswer((_) async => Right(tTransactions));
        //act
        final result = await usecase({});
        //assert
        expect(result, Right(tTransactions));
        verify(mockTransactionRepository.getTransactions({}));
        verifyNoMoreInteractions(mockTransactionRepository);
      },
  );

}