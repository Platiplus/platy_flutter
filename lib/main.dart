import 'package:flutter/material.dart';
import 'package:platy/routes.dart';


void main() => runApp(MaterialApp(
  home: Platy(),
  debugShowCheckedModeBanner: false,
));

class Platy extends StatelessWidget {
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Platy',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}