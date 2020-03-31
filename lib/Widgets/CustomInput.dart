import 'package:flutter/material.dart';
import 'package:platy/Styles/style_constants.dart' as Theme;

Widget customInput(
    {
      bool obscure = false,
      TextInputType inputType = TextInputType.text,
      String hintText,
      Icon prefixIcon,
      IconButton suffixIcon,
      TextEditingController controller,
      FocusNode focusNode,
      FocusNode nextFocus,
      BuildContext context })
{
  return TextField(
    controller: controller,
    focusNode: focusNode,
    onSubmitted: (term){
      focusNode.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    },
    obscureText: obscure,
    keyboardType: inputType,
    style: TextStyle(
        color: Theme.primaryTextColor
    ),
    decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(top: 14.0),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.hintTextColor,
          fontFamily: Theme.primaryFontFamily,
          fontSize: Theme.twoItemsMenuFontSize,
          fontWeight: FontWeight.w400
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: prefixIcon,
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: suffixIcon,
        ),
    ),
  );
}