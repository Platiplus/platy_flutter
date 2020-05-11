import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/core/network/NetworkInfo.dart';
import 'package:platy/features/manage_users/data/datasources/UserDataSource.dart';
import 'package:platy/features/manage_users/data/models/TokensModel.dart';
import 'package:platy/features/manage_users/data/models/UserInfoDTO.dart';
import 'package:platy/features/manage_users/data/models/UserLoginDTO.dart';
import 'package:platy/features/manage_users/data/models/UserModel.dart';
import 'package:platy/features/manage_users/domain/interfaces/repositories/IUserRepository.dart';

class UserRepository implements IUserRepository {
  final UserDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepository({ this.remoteDataSource, this.networkInfo });

  @override
  Future<Either<Error, TokensModel>> login(UserLoginDTO credentials) async {
    if (!await connection()) return Left(NetworkError());

    final remoteTokens = await remoteDataSource.login(credentials);

    return remoteTokens;
  }

  @override
  Future<Either<Error, UserInfoDTO>> signup(UserModel user) async {
    if (!await connection()) return Left(NetworkError());

    final remoteUser = await remoteDataSource.signup(user);

    return remoteUser;
  }

  Future<bool> connection() async {
    var connected = await networkInfo.isConnected;

    if(connected) {
      return true;
    }

    return false;
  }
}