import 'package:platy/features/manage_users/domain/entities/Tokens.dart';

class TokensModel extends Tokens {
  TokensModel({
    String accessToken,
    String refreshToken,
  }) : super(accessToken : accessToken, refreshToken: refreshToken );

  factory TokensModel.fromJson(Map<String, dynamic> json) => TokensModel(
    accessToken: json['token'],
    refreshToken: json['refreshToken'],
  );
}