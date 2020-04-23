import 'dart:convert';
import 'package:platy/core/constants/endpoint_constants.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';
import 'package:platy/features/manage_transactions/domain/interfaces/datasources/ITransactionDataSource.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TransactionDataSource implements ITransactionDataSource {
  final http.Client client;

  TransactionDataSource({ this.client });

  @override
  Future<List<TransactionModel>> getTransactions(params) async {
    Map<String, String> query = Map.from(params);

    var uri = new Uri.https(apiBaseUrl, getTransactionsUrl, query);
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //var token = sharedPreferences.getString('accessToken');

    var response = await client.get(uri, headers: { 'authorization': 'Bearer ' + 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI1ZTc2ZDFiMTFjOWQ0NDAwMDBlNTAwNzUiLCJpYXQiOjE1ODc0ODgxNTQsImV4cCI6MTU4NzU3NDU1NCwiYXVkIjoicGxhdHkuY29tIiwiaXNzIjoiUGxhdHkifQ.RLTDig_xrUfMOSjeikuxKIlkPYRCRg-z-0kGqRzd-sdmXLvzav5-m_pRMwXVXNKsOya1XuCsR1liDDAonSEuNA' });

    var jsonList = json.decode(response.body) as List;
    List<TransactionModel> transactions = jsonList.map((t) => TransactionModel.fromJson(t)).toList();

    return transactions;
  }
}