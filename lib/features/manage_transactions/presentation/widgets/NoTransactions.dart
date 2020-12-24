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
            width: 173,
            height: 192,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/illustrations/platy-notransactions.png'),
                    alignment: Alignment.bottomCenter
                ),
                color: Colors.white
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