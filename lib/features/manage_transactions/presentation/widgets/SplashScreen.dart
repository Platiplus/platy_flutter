import 'package:flutter/material.dart';
import 'package:platy/core/helpers/constants/style_constants.dart' as Theme;

Widget splashScreen(BuildContext context)
{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  return new Scaffold(
    key: _scaffoldKey,
    resizeToAvoidBottomPadding: true,
    body: NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
        return true;
        },
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height >= 775.0
              ? MediaQuery.of(context).size.height : 775.0,
          decoration: new BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/illustrations/platy-splash.png'),
                  alignment: Alignment.center,
              ),
              color: Theme.appBackgroundColor
          ),
          child: Column(),
        ),
      ),
    ),
  );
}