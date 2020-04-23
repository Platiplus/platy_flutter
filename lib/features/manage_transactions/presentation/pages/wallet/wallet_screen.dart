import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Wallet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            color: Colors.red,
            child: Text('Wallet Screen'),
          ),
        ]
    );
  }
}