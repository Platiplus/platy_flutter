import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/core/interfaces/usecases/IUseCaseWithParams.dart';
import 'package:platy/features/manage_users/data/models/TokensModel.dart';
import 'package:platy/features/manage_users/data/models/UserLoginDTO.dart';
import 'package:platy/features/manage_users/domain/interfaces/repositories/IUserRepository.dart';

class UserLogin implements IUseCaseWithParams<TokensModel, UserLoginDTO>{
  final IUserRepository repository;

  UserLogin(this.repository);

  @override
  Future<Either<SignInError, TokensModel>> call(UserLoginDTO credentials) async {
    return await repository.login(credentials);
  }
}