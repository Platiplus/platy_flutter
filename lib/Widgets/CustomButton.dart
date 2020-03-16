
import 'package:flutter/material.dart';
import 'package:platy/Utils/style_constants.dart' as Theme;

Widget CustomButton(String text){
  return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: Theme.buttonTextSize,
        letterSpacing: Theme.buttonLetterSpacing,
        fontFamily: Theme.primaryFontFamily,
        fontWeight: FontWeight.bold
      )
  );
}