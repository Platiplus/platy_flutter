import 'package:platy/features/manage_users/domain/entities/User.dart';

class UserInfoDTO extends User {
  UserInfoDTO({
    String id,
    String username,
    String email,
    double initialBalance
  }) : super(id: id, username: username, email: email, initialBalance: initialBalance);

  factory UserInfoDTO.fromJson(Map<String, dynamic> json) => UserInfoDTO(
    id: json['_id'],
    username: json['username'],
    email: json['email'],
    initialBalance: json['initialBalance'].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "email": email,
    "initialBalance": initialBalance.toString(),
  };

}