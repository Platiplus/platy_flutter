import 'package:flutter/material.dart';
import 'package:platy/Screens/forgot_password/forgot_password_screen.dart';
import 'package:platy/Screens/login/login_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => Login());
        break;

      case 'login':
        return MaterialPageRoute(builder: (_) => Login());
        break;

      case 'forgot':
        return MaterialPageRoute(builder: (_) => ForgotPassword());
        break;

      default:
        return MaterialPageRoute(builder: (_) => Login());
        break;
    }
  }
}