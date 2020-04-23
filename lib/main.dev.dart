import 'package:flutter/material.dart';
import 'package:platy/routes.dart';
import 'package:platy/Utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:platy/Styles/Styles.dart' as Theme;
import 'dart:convert';

void main() => runApp(MaterialApp(
  home: Platy(),
  debugShowCheckedModeBanner: false,
));

class Platy extends StatefulWidget {
  @override
  PlatyState createState() => new PlatyState();
}

class PlatyState extends State<Platy> {
  var homePage = '';

  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getLoggedUser(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.active:
          case ConnectionState.waiting:
          case ConnectionState.none:
            return Text('Loading');

          case ConnectionState.done:
            if(snapshot.data){
              homePage = 'home';
            } else {
              homePage = 'login';
            }
            break;
        }
        print(homePage);
        return new GestureDetector(
            child: MaterialApp(
              title: 'Platy',
              theme: new ThemeData(
                  primarySwatch: Colors.indigo,
                  textSelectionHandleColor: Theme.inputSelectableIconColor
              ),
              initialRoute: homePage,
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
    );
  }

  Future<bool> getLoggedUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var refreshToken = sharedPreferences.getString('refreshToken');

    if(refreshToken != null){
      var response = await http.post(refreshUrl, headers: { 'authorization': refreshToken });
      if (response.statusCode == 200){
        var token = json.decode(response.body)['token'];
        sharedPreferences.setString('accessToken', token);
        return true;
      }
    }
    return false;
  }

}