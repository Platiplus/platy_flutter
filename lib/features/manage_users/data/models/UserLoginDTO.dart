import 'package:platy/features/manage_users/domain/entities/User.dart';

class UserLoginDTO extends User {
  UserLoginDTO({
    String email,
    String password,
  }) : super(email: email, password: password);

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };

}