import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platy/core/network/NetworkInfo.dart';
import 'package:platy/features/manage_transactions/data/datasources/TransactionDataSource.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';
import 'package:platy/features/manage_transactions/data/repositories/TransactionRepository.dart';
import 'package:platy/features/manage_transactions/domain/entities/Transaction.dart';

class MockRemoteDataSource extends Mock implements TransactionDataSource {}
class MockNetworkInfo extends Mock implements NetworkInfo {}

void main () {
  TransactionRepository repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp((){
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TransactionRepository(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo
    );
  });

  final Map<String, dynamic> tParams = {
    "type": 1,
    "status": true
  };

  final tTransactionModel = TransactionModel(
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
  );

  Transaction tTransaction = tTransactionModel;

  test(
    'should check if the device is online and get transactions',
      () async {
        //arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        //act
        repository.getTransactions(tParams);
        //assert
        verify(mockNetworkInfo.isConnected);
      }
  );
}