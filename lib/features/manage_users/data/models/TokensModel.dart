import 'package:platy/features/manage_users/domain/entities/Tokens.dart';

class TokensModel extends Tokens {
  TokensModel({
    String accessToken,
    String refreshToken,
    String userId,
    String accountId
  }) : super(accessToken : accessToken, refreshToken: refreshToken, userId: userId, accountId: accountId );

  factory TokensModel.fromJson(Map<String, dynamic> json) => TokensModel(
    accessToken: json['token'],
    refreshToken: json['refreshToken'],
    userId: json['userId'],
    accountId: json['accountId']
  );
}