import 'package:flutter/material.dart';
import 'package:platy/features/manage_transactions/presentation/pages/create_transaction/create_transaction_screen.dart';
import 'package:platy/features/manage_transactions/presentation/pages/edit_transaction/edit_transaction_screen.dart';
import 'package:platy/features/manage_users/presentation/pages/forgot_password/forgot_password_screen.dart';
import 'package:platy/features/manage_transactions/presentation/pages/home/home_screen.dart';
import 'package:platy/features/manage_users//presentation/pages/login/login_screen.dart';
import 'package:platy/features/manage_transactions/presentation/pages/home/details/details_screen.dart';
import 'features/manage_transactions/presentation/pages/calendar/month_calendar_screen.dart';
import 'features/manage_transactions/presentation/pages/calendar/year_calendar_screen.dart';

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
        break;

      case 'create-transaction':
        return MaterialPageRoute(builder: (_) => CreateTransaction());
        break;

      case 'edit-transaction':
        return MaterialPageRoute(builder: (_) => EditTransaction(args: args));
        break;

      case 'month-calendar':
        return MaterialPageRoute(builder: (_) => MonthCalendar(callback: args));
        break;

      case 'year-calendar':
        return MaterialPageRoute(builder: (_) => YearCalendar(callback: args));
        break;

      default:
        return MaterialPageRoute(builder: (_) => Login());
        break;
    }
  }
}