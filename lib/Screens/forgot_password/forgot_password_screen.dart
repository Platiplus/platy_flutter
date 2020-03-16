import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:platy/Utils/Utils.dart' as Theme;
import 'package:platy/Widgets/CustomWidgets.dart';

class ForgotPassword extends StatefulWidget {
  @override
  ForgotPasswordState createState() => new ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController forgotPasswordController = new TextEditingController();

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
                    Row(
                      children: <Widget>[
                        Text(
                          "Esqueceu a senha?",
                          style: TextStyle(
                              fontFamily: Theme.primaryFontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: Theme.header1FontSize,
                              color: Theme.primaryHeaderColor
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(25),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Digite seu e-mail e vamos enviar \ninstruções para que você a redefina",
                          style: TextStyle(
                              fontFamily: Theme.primaryFontFamily,
                              fontSize: Theme.header2FontSize,
                              color: Color(0xFF4A515E)
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(50),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: Theme.formFieldsStyle,
                      height: 60.0,
                      child: CustomInput(
                          inputType: TextInputType.emailAddress,
                          hintText: 'Email',
                          prefixIcon: Icon(FontAwesomeIcons.envelope, color: Theme.hintTextColor, size: 18),
                          controller: forgotPasswordController,
                      ) //CustomInput
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(35),
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
                                child: CustomButton('Enviar')
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
}