import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            color: Colors.blue,
            child: Text('Profile Screen'),
          ),
        ]
    );
  }
}