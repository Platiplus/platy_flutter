import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:platy/core/interfaces/network/INetworkInfo.dart';

class NetworkInfo implements INetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfo(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}