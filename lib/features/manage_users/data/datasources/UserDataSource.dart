import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:platy/core/error/Failures.dart';
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
  Future<Either<SignInError, TokensModel>> login(UserLoginDTO credentials) async {
    var uri = new Uri(scheme: scheme, host: authBaseUrl, pathSegments: [authenticationUrl, signIn]);
    var response = await client.post(uri, body: credentials.toJson());

    var responseMap = json.decode(response.body);

    if (response.statusCode != 200) {
      return Left(SignInError(response.statusCode, responseMap['message']));
    } else {
      return Right(TokensModel.fromJson(responseMap));
    }
  }

  Future<Either<SignUpError, UserInfoDTO>> signup(UserModel user) async {
    var uriUser = new Uri(scheme: scheme, host: apiBaseUrl, path: signupUrl);
    var responseUser = await client.post(uriUser, body: user.toJson());
    var userMap = json.decode(responseUser.body);

    if (responseUser.statusCode != 201) {
      return Left(SignUpError(responseUser.statusCode, userMap['message']));
    } else {
      var uriAccount = new Uri(scheme: scheme, host: apiBaseUrl, path: createAccountUrl);
      var responseAccount = await client.post(uriAccount, body: { 'description': 'BankAccount', 'balance': '0.0', 'owner': userMap['users'][0]['_id'] });
      var accountMap = json.decode(responseAccount.body);

      if (responseUser.statusCode != 201) {
        return Left(SignUpError(responseAccount.statusCode, accountMap['message']));
      } else {
        return Right(UserInfoDTO.fromJson(userMap['users'][0]));
      }
    }
  }
}