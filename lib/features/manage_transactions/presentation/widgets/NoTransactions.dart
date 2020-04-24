import 'package:flutter/material.dart';
import 'package:platy/core/helpers/constants/style_constants.dart' as Theme;

Widget noTransactions()
{
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 75.0, bottom: 30),
        child: InkWell(
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Color(0xFFD8D8D8),
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
        ),
      ),
      Text(
        'Nenhum valor lançado.\nComece agora!',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.supportTextColor,
          fontSize: Theme.supportFontSize,
          fontFamily: Theme.primaryFontFamily,
        ),
      )
    ],
  );
}