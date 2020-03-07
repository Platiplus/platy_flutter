import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:platy/Utils/endpoint_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:platy/Utils/style_constants.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  LoginState createState() => new LoginState();
}

class LoginState extends State<Login> {

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context){
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);

    return new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: true,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 35.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        BackButton(
                            color: Color(0xFF6C4BB6)
                        )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(40),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: formFieldsStyle,
                      height: 60.0,
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Color(0xFF606A7B)),
                        decoration: inputStyle('Email'),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(25),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: formFieldsStyle,
                      height: 60.0,
                      child: TextField(
                        obscureText: obscurePassword,
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(color: Color(0xFF606A7B)),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14.0, left: 25.0),
                          hintText: 'Senha',
                          hintStyle: TextStyle(
                            color: Color(0xFF606A7B),
                            fontFamily: 'Montserrat',
                          ),
                          suffixIcon: IconButton(
                            onPressed: showPassword,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            icon: Icon(obscurePassword == true ? Icons.visibility : Icons.visibility_off),
                            padding: EdgeInsets.only(right: 14.0),
                            color: Color(0xFF606A7B),
                          )
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(25),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 26.0),
                      height: 60.0,
                      child: Text(
                        "Esqueceu a senha?",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Color(0xFF6C4BB6),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment(0.75, 0.0),
                                colors: [
                                  Color(0xFF1680ff),
                                  Color(0xFF7644ad)
                                ]
                            ),
                            borderRadius: BorderRadius.circular(50.0),

                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(50.0),
                              onTap: () => {
                              },
                              child: Center(
                                child: Text(
                                  "ENTRAR",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    letterSpacing: 1.0,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
    );
  }

  //Functions
  signIn(String email, String password) async {
    Map data = {
      'email': email,
      'password': password
    };
    var token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http.post(authentication_url, body: data);

    if(response.statusCode == 201) {
      token = json.decode(response.body);
      setState(() {
        sharedPreferences.setString('token', token);
        Navigator.of(context).pushNamed('home');
      });
    } else {
      print('Não autenticou!');
    }
  }

  showPassword(){
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }
}