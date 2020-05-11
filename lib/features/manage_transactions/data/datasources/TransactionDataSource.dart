import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/core/helpers/constants/endpoint_constants.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';
import 'package:platy/features/manage_transactions/domain/interfaces/datasources/ITransactionDataSource.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransactionDataSource implements ITransactionDataSource {
  final http.Client client;

  TransactionDataSource({ this.client });

  @override
  Future<Either<TransactionError, List<TransactionModel>>> getAllTransactions() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('accessToken');

    var uri = new Uri(scheme: scheme, host: apiBaseUrl, path: getTransactionsUrl);
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
  }

  Future<Either<TransactionError, List<TransactionModel>>> getTransactionsByParams(params) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('accessToken');

    Map<String, String> query = Map.from(params);
    var uri = new Uri(scheme: scheme, host: apiBaseUrl, path: getTransactionsUrl, queryParameters: query);

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
  }
}