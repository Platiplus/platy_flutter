import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/core/helpers/constants/endpoint_constants.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionCreateModel.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';
import 'package:platy/features/manage_transactions/domain/interfaces/datasources/ITransactionDataSource.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransactionDataSource implements ITransactionDataSource {
  final http.Client client;

  TransactionDataSource({ this.client });

  @override
  Future<Either<Error, List<TransactionModel>>> getAllTransactions() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('accessToken');

    var uri = new Uri(scheme: 'http', host: '192.168.15.6', path: getTransactionsUrl, port: 8080);

    try {
      var response = await client.get(uri, headers: { 'authorization': 'Bearer ' + token });
      var responseMap = json.decode(response.body);

      if (response.statusCode != 200) {
        return Left(TransactionError(response.statusCode, responseMap['message']));
      } else {
        var list = new List<TransactionModel>();

        if (responseMap['count'] != 0) {
          for (var transaction in responseMap['transactions']) {
            list.add(TransactionModel.fromJson(transaction));
          }
        }
        return Right(list);
      }
    } on Exception {
      return Left(ServerOfflineError());
    }
  }

  Future<Either<Error, List<TransactionModel>>> getTransactionsByParams(params) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('accessToken');

    Map<String, String> query = Map.from(params);
    var uri = new Uri(scheme: 'http', host: '192.168.15.6', path: getTransactionsUrl, queryParameters: query, port: 8080);

    try {
      var response = await client.get(
          uri, headers: { 'authorization': 'Bearer ' + token});
      var responseMap = json.decode(response.body);

      if (response.statusCode != 200) {
        return Left(
            TransactionError(response.statusCode, responseMap['message']));
      } else {
        var list = new List<TransactionModel>();

        if (responseMap['count'] != 0) {
          for (var transaction in responseMap['transactions']) {
            list.add(TransactionModel.fromJson(transaction));
          }
        }
        return Right(list);
      }
    } on Exception {
      return Left(ServerOfflineError());
    }
  }

  @override
  Future<Either<Error, List<TransactionModel>>> createTransactions(TransactionCreateModel transaction) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var createUrl = transaction.quotas != 'unique' ? createManyTransactionsUrl : createTransactionsUrl;

    var token = sharedPreferences.getString('accessToken');
    var uri = new Uri(scheme: 'http', host: '192.168.15.6', path: createUrl, port: 8080);

    try {
      var response = await client.post(uri, headers: { 'authorization': 'Bearer ' + token, 'content-type': 'application/json' }, body: json.encode(transaction.toJson()));

      var responseMap = json.decode(response.body);

      if (response.statusCode != 201) {
        return Left(TransactionError(response.statusCode, responseMap['message']));
      } else {
        var list = new List<TransactionModel>();

        if (responseMap['count'] != 0) {
          for (var transaction in responseMap['transactions']) {
            list.add(TransactionModel.fromJson(transaction));
          }
        }
        return Right(list);
      }
    } on Exception {
      return Left(ServerOfflineError());
    }
  }
}