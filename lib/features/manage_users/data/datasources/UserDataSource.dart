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
    var uri = new Uri(scheme: scheme, host: authBaseUrl, path: authenticationUrl);
    var response = await client.post(uri, body: credentials.toJson());

    var responseMap = json.decode(response.body);

    if (response.statusCode != 200) {
      return Left(SignInError(response.statusCode, responseMap['message']));
    } else {
      return Right(TokensModel.fromJson(responseMap));
    }
  }

  Future<Either<SignUpError, UserInfoDTO>> signup(UserModel user) async {
    var uri = new Uri(scheme: scheme, host: apiBaseUrl, path: signupUrl);
    var response = await client.post(uri, body: user.toJson());

    var responseMap = json.decode(response.body);

    if (response.statusCode != 201) {
      return Left(SignUpError(response.statusCode, responseMap['message']));
    } else {
      return Right(UserInfoDTO.fromJson(responseMap['users'][0]));
    }
  }
}