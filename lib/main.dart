import 'package:flutter/material.dart';
import 'package:platy/routes.dart';
import 'package:platy/core/helpers/styles/Styles.dart' as Theme;

import 'injection_container.dart';

void main() {
  Injector.setup();
  runApp(MaterialApp(
  home: Platy(),
  debugShowCheckedModeBanner: false,
  ));
}

class Platy extends StatelessWidget {
  Widget build(BuildContext context) {
    return new GestureDetector(
        child: MaterialApp(
          title: 'Platy',
          theme: new ThemeData(
              primarySwatch: Colors.indigo,
              textSelectionHandleColor: Theme.inputSelectableIconColor
          ),
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        });
  }
}