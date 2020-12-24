import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/core/helpers/constants/endpoint_constants.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionCreateModel.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionUpdateManyModel.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionUpdateModel.dart';
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

    var uri = new Uri(scheme: scheme, host: apiBaseUrl, pathSegments: [getTransactionsUrl, all]);

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
    var uri = new Uri(scheme: scheme, host: apiBaseUrl, pathSegments: [getTransactionsUrl, all], queryParameters: query);

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
    var uri = new Uri(scheme: scheme, host: apiBaseUrl, path: createUrl);

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

  @override
  Future<Either<Error, List<TransactionModel>>> updateTransaction(TransactionUpdateModel transaction) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var transactionToUpdate = new TransactionCreateModel(
      account: transaction.account,
      category: transaction.category,
      date: transaction.date,
      description: transaction.description,
      quotas: transaction.quotas,
      status: transaction.status,
      target: transaction.target,
      type: transaction.type,
      value: transaction.value,
    );

    var token = sharedPreferences.getString('accessToken');
    var uri = new Uri(scheme: scheme, host: apiBaseUrl, pathSegments: [updateTransactionsUrl, transaction.id]);
    try {
      var response = await client.patch(uri, headers: { 'authorization': 'Bearer ' + token, 'content-type': 'application/json' }, body: json.encode(transactionToUpdate.toJson()));

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

  @override
  Future<Either<Error, List<TransactionModel>>> updateTransactions(TransactionUpdateModel transaction) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var transactionToUpdate = new TransactionUpdateManyModel(
      account: transaction.account,
      category: transaction.category,
      description: transaction.description,
      quotas: transaction.quotas,
      status: transaction.status,
      target: transaction.target,
      type: transaction.type,
      value: transaction.value,
    );

    var token = sharedPreferences.getString('accessToken');
    var uri = new Uri(scheme: scheme, host: apiBaseUrl, pathSegments: [updateTransactionsUrl, many, transaction.id]);

    try {
      var response = await client.patch(uri, headers: { 'authorization': 'Bearer ' + token, 'content-type': 'application/json' }, body: json.encode(transactionToUpdate.toJson()));

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

  @override
  Future<Either<Error, List<TransactionModel>>> deleteTransaction(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('accessToken');

    var uri = new Uri(scheme: scheme, host: apiBaseUrl, pathSegments: [deleteTransactionsUrl, id]);

    try {
      var response = await client.delete(uri, headers: { 'authorization': 'Bearer ' + token });
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

  @override
  Future<Either<Error, List<TransactionModel>>> deleteTransactions(String id, String quotas) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('accessToken');

    var uri = new Uri(scheme: scheme, host: apiBaseUrl, pathSegments: [deleteTransactionsUrl, many, id]);

    try {
      var request = Request('DELETE', uri);
      request.headers.addAll({ 'authorization': 'Bearer ' + token });
      request.bodyFields = { 'quotas': quotas };

      var response = await client.send(request);

      if (response.statusCode != 200) {
        return Left(TransactionError(response.statusCode, 'message'));
      } else {
        var list = new List<TransactionModel>();
        return Right(list);
      }
    } on Exception {
      return Left(ServerOfflineError());
    }
  }
}