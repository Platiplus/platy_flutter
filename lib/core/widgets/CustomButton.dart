
import 'package:flutter/material.dart';
import 'package:platy/core/helpers/constants/style_constants.dart' as Theme;

Widget customButton(String text){
  return Text(
      text,
      style: TextStyle(
        color: Theme.buttonTextColor,
        fontSize: Theme.buttonFontSize,
        letterSpacing: Theme.buttonLetterSpacing,
        fontFamily: Theme.primaryFontFamily,
        fontWeight: FontWeight.bold
      )
  );
}