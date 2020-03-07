import 'package:flutter/material.dart';
import 'package:platy/screens/home/home_screen.dart';
import 'package:platy/screens/welcome/welcome_screen.dart';
import 'package:platy/screens/login/login_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => Welcome());
        break;

      case 'home':
        return MaterialPageRoute(builder: (_) => Home());
        break;

      case 'login':
        return MaterialPageRoute(builder: (_) => Login());

      default:
        return MaterialPageRoute(builder: (_) => Welcome());
        break;
    }
  }
}