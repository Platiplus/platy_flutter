import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/features/manage_users/data/models/TokensModel.dart';
import 'package:platy/features/manage_users/data/models/UserInfoDTO.dart';
import 'package:platy/features/manage_users/data/models/UserLoginDTO.dart';
import 'package:platy/features/manage_users/data/models/UserModel.dart';

abstract class IUserDataSource {
  Future<Either<SignInError, TokensModel>> login(UserLoginDTO credentials);
  Future<Either<SignUpError, UserInfoDTO>> signup(UserModel user);
}