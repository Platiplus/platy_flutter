import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
import 'package:platy/core/interfaces/usecases/IUseCaseWithParams.dart';
import 'package:platy/features/manage_users/data/models/UserInfoDTO.dart';
import 'package:platy/features/manage_users/data/models/UserModel.dart';
import 'package:platy/features/manage_users/domain/interfaces/repositories/IUserRepository.dart';

class UserSignup implements IUseCaseWithParams<UserInfoDTO, UserModel>{
  final IUserRepository repository;

  UserSignup(this.repository);

  @override
  Future<Either<Failure, UserInfoDTO>> call(UserModel user) async {
    return await repository.signup(user);
  }
}