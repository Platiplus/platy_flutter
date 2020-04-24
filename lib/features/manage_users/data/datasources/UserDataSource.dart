import 'dart:convert';
import 'package:platy/core/helpers/constants/endpoint_constants.dart';
import 'package:http/http.dart' as http;
import 'package:platy/features/manage_users/data/models/TokensModel.dart';
import 'package:platy/features/manage_users/data/models/UserInfoDTO.dart';
import 'package:platy/features/manage_users/data/models/UserLoginDTO.dart';
import 'package:platy/features/manage_users/data/models/UserModel.dart';
import 'package:platy/features/manage_users/domain/interfaces/datasources/IUserDataSource.dart';

class UserDataSource implements IUserDataSource {
  final http.Client client;

  UserDataSource({ this.client });

  @override
  Future<TokensModel> login(UserLoginDTO credentials) async {
    var uri = new Uri(scheme: scheme, host: apiBaseUrl, path: authenticationUrl);
    var response = await client.post(uri, body: credentials.toJson());

    var tokenMap = json.decode(response.body);

    return TokensModel.fromJson(tokenMap);
  }

  Future<UserInfoDTO> signup(UserModel user) async {
    var uri = new Uri(scheme: scheme, host: apiBaseUrl, path: signupUrl);

    var response = await client.post(uri, body: user.toJson());

    var userMap = json.decode(response.body);

    return UserInfoDTO.fromJson(userMap);
  }
}