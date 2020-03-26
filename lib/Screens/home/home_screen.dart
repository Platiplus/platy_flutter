import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {

  @override
  Widget build(BuildContext context){

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
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}