import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';
import 'package:platy/features/manage_transactions/domain/entities/Transaction.dart';

import '../../../../fixtures/FixtureReader.dart';

void main() {
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
  
  test(
    'should be a subclass of Transaction entity',
      () async {
        //assert
          expect(tTransactionModel, isA<Transaction>());
        }
  );
  test(
    'should return a valid model when the JSON is valid',
      () async {
        //arrange
          final Map<String, dynamic> jsonMap =
            json.decode(fixture('transaction.json'));
        //act
          final result = TransactionModel.fromJson(jsonMap);
        //assert
          expect(result.id, tTransactionModel.id);
        }
  );
}