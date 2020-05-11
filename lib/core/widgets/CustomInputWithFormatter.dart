import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:platy/core/helpers/constants/style_constants.dart' as Theme;

Widget customInputWithFormatter(
    {
      bool obscure = false,
      TextInputType inputType = TextInputType.text,
      String hintText,
      Icon prefixIcon,
      IconButton suffixIcon,
      TextEditingController controller,
      FocusNode focusNode,
      FocusNode nextFocus,
      BuildContext context,
      MaskTextInputFormatter inputFormatter})
{
  return TextField(
    inputFormatters: [inputFormatter],
    controller: controller,
    focusNode: focusNode,
    onSubmitted: (term){
      focusNode.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    },
    obscureText: obscure,
    keyboardType: inputType,
    style: TextStyle(
        color: Theme.dirtyInputTextColor,
        fontWeight: Theme.dirtyInputFontWeight
    ),
    decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(left: 16.0),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.hintTextColor,
          fontFamily: Theme.primaryFontFamily,
          fontSize: Theme.inputFontSize,
        ),
    ),
  );
}