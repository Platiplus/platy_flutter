import 'package:flutter/material.dart';
import 'package:platy/features/manage_transactions/presentation/pages/forgot_password/forgot_password_screen.dart';
import 'package:platy/features/manage_transactions/presentation/pages/home/home_screen.dart';
import 'package:platy/features/manage_users//presentation/pages/login/login_screen.dart';
import 'package:platy/features/manage_transactions/presentation/pages/home/details/details_screen.dart';

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

      case 'home':
        return MaterialPageRoute(builder: (_) => Home());

      case 'forgot':
        return MaterialPageRoute(builder: (_) => ForgotPassword());
        break;

      case 'home-details':
        return MaterialPageRoute(builder: (_) => HomeDetails(transactions: args));

      default:
        return MaterialPageRoute(builder: (_) => Login());
        break;
    }
  }
}