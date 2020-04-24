import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Exceptions.dart';
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
  Future<Either<Failure, TokensModel>> login(UserLoginDTO credentials) async {
    try {
    await connection();

    final remoteTokens = await remoteDataSource.login(credentials);

    if(remoteTokens.accessToken == null)
      return Left(ServerFailure());

    return Right(remoteTokens);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserInfoDTO>> signup(UserModel user) async {
    try {
      await connection();

      final remoteUser = await remoteDataSource.signup(user);

      if(remoteUser.id == null)
        return Left(ServerFailure());

      return Right(remoteUser);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<void> connection() async {
    var connected = await networkInfo.isConnected;
    if(!connected){
      throw ServerException();
    }
  }
}