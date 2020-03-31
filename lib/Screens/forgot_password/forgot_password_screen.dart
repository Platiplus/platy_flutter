// FLUTTER DEPENDENCIES
import 'package:flutter/material.dart';

// EXTERNAL DEPENDENCIES
import 'package:platy/Styles/Styles.dart' as Theme;
import 'package:platy/Widgets/Widgets.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  ForgotPasswordState createState() => new ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {

  //VARIABLES
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController forgotPasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height >= 775.0
            ? MediaQuery.of(context).size.height
            : 775.0,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: BackButton(
                    color: Color(0xFF6C4BB6),
                  )
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 15.0),
                child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          "Esqueceu a senha?",
                          style: TextStyle(
                              fontFamily: Theme.primaryFontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: Theme.header1FontSize,
                              color: Theme.primaryHeaderColor),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Text(
                          "Digite seu e-mail e vamos enviar \ninstruções para que você a redefina",
                          style: TextStyle(
                              fontFamily: Theme.primaryFontFamily,
                              fontSize: Theme.header2FontSize,
                              color: Color(0xFF4A515E)),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: Theme.formFieldsStyle,
                      height: 60.0,
                      child: customInput(
                        inputType: TextInputType.emailAddress,
                        hintText: 'E-mail',
                        prefixIcon: Icon(CSIcons.mail, color: Theme.inputIconColor, size: Theme.inputIconSize),
                        controller: forgotPasswordController,
                      ),// CustomInput
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
                            onTap: () => {},
                            child: Center(
                                child: customButton('Enviar')
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}