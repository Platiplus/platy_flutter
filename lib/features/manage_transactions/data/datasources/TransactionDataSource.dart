import 'dart:convert';
import 'package:platy/core/helpers/constants/endpoint_constants.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';
import 'package:platy/features/manage_transactions/domain/interfaces/datasources/ITransactionDataSource.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransactionDataSource implements ITransactionDataSource {
  final http.Client client;

  TransactionDataSource({ this.client });

  @override
  Future<List<TransactionModel>> getAllTransactions() async {

    var uri = new Uri(scheme: scheme, host: apiBaseUrl, path: getTransactionsUrl);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('accessToken');

    var response = await client.get(uri, headers: { 'authorization': 'Bearer ' + token });

    var jsonList = json.decode(response.body) as List;
    List<TransactionModel> transactions = jsonList.map((t) => TransactionModel.fromJson(t)).toList();

    return transactions;
  }

  Future<List<TransactionModel>> getTransactionsByParams(params) async {
    Map<String, String> query = Map.from(params);

    var uri = new Uri(scheme: scheme, host: apiBaseUrl, path: getTransactionsUrl, queryParameters: query);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('accessToken');

    var response = await client.get(uri, headers: { 'authorization': 'Bearer ' + token });

    var jsonList = json.decode(response.body) as List;
    List<TransactionModel> transactions = jsonList.map((t) => TransactionModel.fromJson(t)).toList();

    return transactions;
  }
}