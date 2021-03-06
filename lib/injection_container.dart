import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import "package:kiwi/kiwi.dart";

import 'package:platy/features/manage_transactions/domain/interfaces/repositories/ITransactionRepository.dart';
import 'package:platy/features/manage_transactions/data/repositories/TransactionRepository.dart';

import 'package:platy/features/manage_transactions/domain/interfaces/datasources/ITransactionDataSource.dart';
import 'package:platy/features/manage_transactions/data/datasources/TransactionDataSource.dart';
import 'package:platy/features/manage_transactions/domain/usecases/CreateTransactions.dart';
import 'package:platy/features/manage_transactions/domain/usecases/DeleteTransaction.dart';

import 'package:platy/features/manage_transactions/domain/usecases/GetTransactions.dart';

import 'package:platy/core/network/NetworkInfo.dart';
import 'package:platy/core/interfaces/network/INetworkInfo.dart';
import 'package:platy/features/manage_transactions/domain/usecases/GetTransactionsByDate.dart';
import 'package:platy/features/manage_transactions/domain/usecases/UpdateTransaction.dart';
import 'package:platy/features/manage_users/data/datasources/UserDataSource.dart';
import 'package:platy/features/manage_users/domain/usecases/UserLogin.dart';
import 'package:platy/features/manage_users/domain/usecases/UserSignup.dart';

import 'package:platy/features/manage_users/data/repositories/UserRepository.dart';
import 'package:platy/features/manage_users/domain/interfaces/datasources/IUserDataSource.dart';
import 'package:platy/features/manage_users/domain/interfaces/repositories/IUserRepository.dart';

import 'features/manage_transactions/domain/usecases/DeleteTransactions.dart';
import 'features/manage_transactions/domain/usecases/UpdateTransactions.dart';

abstract class Injector {
  static Container container;

  static void setup(){
    container = Container();

    // CORE
    container.registerSingleton((c) => DataConnectionChecker());
    container.registerSingleton((c) => http.Client());
    container.registerSingleton<INetworkInfo, NetworkInfo>((c) => NetworkInfo(c<DataConnectionChecker>()));
    // DATASOURCES
    container.registerSingleton<ITransactionDataSource, TransactionDataSource>((c) => TransactionDataSource(client: Client()));
    container.registerSingleton<IUserDataSource, UserDataSource>((c) => UserDataSource(client: Client()));
    // REPOSITORIES
    container.registerSingleton<ITransactionRepository, TransactionRepository>((c) => TransactionRepository(remoteDataSource: c<ITransactionDataSource>(), networkInfo: c<INetworkInfo>()));
    container.registerSingleton<IUserRepository, UserRepository>((c) => UserRepository(remoteDataSource: c<IUserDataSource>(), networkInfo: c<INetworkInfo>()));
    // USECASES
    container.registerSingleton((c) => GetAllTransactions(c<ITransactionRepository>()));
    container.registerSingleton((c) => GetTransactionsByDate(c<ITransactionRepository>()));
    container.registerSingleton((c) => CreateTransactions(c<ITransactionRepository>()));
    container.registerSingleton((c) => UpdateTransaction(c<ITransactionRepository>()));
    container.registerSingleton((c) => UpdateTransactions(c<ITransactionRepository>()));
    container.registerSingleton((c) => DeleteTransaction(c<ITransactionRepository>()));
    container.registerSingleton((c) => DeleteTransactions(c<ITransactionRepository>()));
    container.registerSingleton((c) => UserLogin(c<IUserRepository>()));
    container.registerSingleton((c) => UserSignup(c<IUserRepository>()));
  }

  static final resolve = container.resolve;
}
