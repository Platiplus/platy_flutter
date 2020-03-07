import 'package:flutter/material.dart';

final formFieldsStyle = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(50.0),
    border: Border.all(width: 1.0, color: Color(0xFFDCDFE6))
);

final formHintStyle = TextStyle(
  color: Color(0xFF606A7B),
  fontFamily: 'Montserrat',
);

final inputStyle = (inputText) => InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.only(top: 5.0, left: 25.0),
      hintText: inputText,
      hintStyle: TextStyle(
        color: Color(0xFF606A7B),
        fontFamily: 'Montserrat',
      )
);