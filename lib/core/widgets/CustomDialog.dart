import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:platy/core/helpers/constants/style_constants.dart' as Theme;

class CustomDialog extends Dialog {
  final String assetPath;
  final double width;
  final double height;
  final String message;
  final Function behaviour;

  CustomDialog({this.assetPath, this.width, this.height, this.message, this.behaviour});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: 200.0,
        width: 280.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Lottie.asset(assetPath, width: 106, height: 76, fit: BoxFit.fill, repeat: false),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.supportHeadersTextColor,
                      fontSize: Theme.behaviorDescriptionFontSize,
                      fontWeight: Theme.supportHeadersFontWeight,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    onPressed: behaviour,
                    child: Text(
                      'OK',
                      style: TextStyle(
                          fontSize: Theme.supportHeaders2Size,
                          color: Theme.inputSelectableIconColor,
                          fontWeight: Theme.supportHeadersFontWeight
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
