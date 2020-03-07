import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
      Column(
      crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text("Rota funcionando!"),
          )
        ],
      ),
    ]
      ),
    );
  }
}