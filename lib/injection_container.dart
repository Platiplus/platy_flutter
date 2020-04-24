import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import "package:kiwi/kiwi.dart";

import 'package:platy/features/manage_transactions/domain/interfaces/repositories/ITransactionRepository.dart';
import 'package:platy/features/manage_transactions/data/repositories/TransactionRepository.dart';

import 'package:platy/features/manage_transactions/domain/interfaces/datasources/ITransactionDataSource.dart';
import 'package:platy/features/manage_transactions/data/datasources/TransactionDataSource.dart';

import 'package:platy/features/manage_transactions/domain/usecases/GetTransactions.dart';

import 'package:platy/core/network/NetworkInfo.dart';
import 'package:platy/core/interfaces/network/INetworkInfo.dart';

abstract class Injector {
  static Container container;

  static void setup(){
    container = Container();

    container.registerSingleton((c) => DataConnectionChecker());
    container.registerSingleton<INetworkInfo, NetworkInfo>((c) => NetworkInfo(c<DataConnectionChecker>()));
    container.registerSingleton<ITransactionDataSource, TransactionDataSource>((c) => TransactionDataSource(client: http.Client()));
    container.registerSingleton<ITransactionRepository, TransactionRepository>((c) => TransactionRepository(remoteDataSource: c<ITransactionDataSource>(), networkInfo: c<INetworkInfo>()));
    container.registerSingleton((c) => GetAllTransactions(c<ITransactionRepository>()));
  }

  static final resolve = container.resolve;
}
