import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/features/manage_users/data/models/TokensModel.dart';
import 'package:platy/features/manage_users/data/models/UserInfoDTO.dart';
import 'package:platy/features/manage_users/data/models/UserLoginDTO.dart';
import 'package:platy/features/manage_users/data/models/UserModel.dart';

abstract class IUserRepository {
  Future<Either<Error, TokensModel>> login(UserLoginDTO credentials);
  Future<Either<Error, UserInfoDTO>> signup(UserModel user);
}