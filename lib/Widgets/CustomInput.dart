import 'package:flutter/material.dart';
import 'package:platy/Utils/style_constants.dart' as Theme;

Widget CustomInput(
    {
      bool obscure = false,
      TextInputType inputType = TextInputType.text,
      String hintText,
      Icon prefixIcon = null,
      IconButton suffixIcon = null,
      TextEditingController controller = null,
      FocusNode focusNode = null,
      FocusNode nextFocus = null,
      BuildContext context })
{
  return TextField(
    controller: controller,
    focusNode: focusNode,
    onSubmitted: (term){
      focusNode.unfocus();
      print(term);
      FocusScope.of(context).requestFocus(nextFocus);
    },
    obscureText: obscure,
    keyboardType: inputType,
    style: TextStyle(
        color: Theme.primaryTextColor
    ),
    decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(top: 13.0),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.hintTextColor,
          fontFamily: Theme.primaryFontFamily,
          fontSize: Theme.menuFontSize,
          fontWeight: FontWeight.w400
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: prefixIcon,
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: 5.0),
          child: suffixIcon,
        ),
    ),
  );
}