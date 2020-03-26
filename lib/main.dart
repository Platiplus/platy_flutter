import 'package:flutter/material.dart';
import 'package:platy/routes.dart';

void main() => runApp(MaterialApp(
  home: Platy(),
  debugShowCheckedModeBanner: false,
));

class Platy extends StatelessWidget {
  Widget build(BuildContext context) {
    return new GestureDetector(
        child: MaterialApp(
          title: 'Platy',
          theme: new ThemeData(
            primarySwatch: Colors.indigo,
            textSelectionHandleColor: Color(0xFF7644AD)
          ),
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        }
        );
      }
  }