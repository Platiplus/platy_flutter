import 'package:platy/features/manage_users/domain/entities/User.dart';

class UserModel extends User {
  UserModel({
    String username,
    String email,
    String password,
    double initialBalance
  }) : super(username: username, email: email, password: password, initialBalance: initialBalance);

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "password": password,
    "initialBalance": initialBalance.toString(),
  };

}