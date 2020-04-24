import 'package:platy/features/manage_users/data/models/TokensModel.dart';
import 'package:platy/features/manage_users/data/models/UserInfoDTO.dart';
import 'package:platy/features/manage_users/data/models/UserLoginDTO.dart';
import 'package:platy/features/manage_users/data/models/UserModel.dart';

abstract class IUserDataSource {
  Future<TokensModel> login(UserLoginDTO credentials);
  Future<UserInfoDTO> signup(UserModel user);
}