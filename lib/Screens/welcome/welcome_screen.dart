import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Welcome extends StatefulWidget {
  @override
  WelcomeState createState() => new WelcomeState();
}

class WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context){
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);

    return new Scaffold(
        backgroundColor: Color(0xFF223254),
        resizeToAvoidBottomPadding: true,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 51.0, right: 51.0, top: 80.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            width: ScreenUtil().setWidth(160),
                            height: ScreenUtil().setHeight(130),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(280),
                    ),
                    Text(
                      "Controle suas finanças e faça as pazes com seu bolso!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold
                      ),
                    ),
//                    FormCard(),
                    SizedBox(height: ScreenUtil().setHeight(200)),
                    Row(
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            width: ScreenUtil().setWidth(500),
                            height: ScreenUtil().setHeight(100),
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
                                  Navigator.of(context).pushNamed('login')
                                },
                                child: Center(
                                  child: Text(
                                    "JÁ SOU CADASTRADO",
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
                        )
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(80),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Não tem uma conta?",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontFamily: 'Montserrat',
                            fontSize: 15.0,
                          )
                        ),
                        FlatButton(
                          onPressed: (){},
                          child: Text(
                            "Cadastre-se",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                                color: Color(0xFFFFFFFF),
                                fontFamily: 'Montserrat',
                                fontSize: 15.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            FittedBox(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/images/backgrounds/initial-bg-01.png'),
              fit: BoxFit.fitWidth,
            ),
            FittedBox(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/images/backgrounds/initial-bg-02.png'),
              fit: BoxFit.fitWidth
            )
          ],
        )
    );
  }
}