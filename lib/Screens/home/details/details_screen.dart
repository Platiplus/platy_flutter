import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platy/Widgets/Widgets.dart';
import 'package:platy/Styles/Styles.dart' as Theme;

class HomeDetails extends StatefulWidget {
  HomeDetails({Key key}) : super(key: key);
  @override
  HomeDetailsState createState() => new HomeDetailsState();
}

class HomeDetailsState extends State<HomeDetails> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height >= 775.0
            ? MediaQuery.of(context).size.height
            : 775.0,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: BackButton(
                      color: Color(0xFF6C4BB6),
                    ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Balanço do mês",
                      style: TextStyle(
                        color: Theme.deselectedBarItemTextColor,
                        fontSize: Theme.warningFontSize,
                        fontFamily: Theme.primaryFontFamily,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 6.0),
                      child: Text(
                        "R\$ ",
                        style: TextStyle(
                            color: Theme.primaryHeaderColor,
                            fontSize: Theme.warningFontSize,
                            fontFamily: Theme.primaryFontFamily,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Text(
                      "4.200,75",
                      style: TextStyle(
                          color: Theme.primaryHeaderColor,
                          fontSize: Theme.header1FontSize,
                          fontFamily: Theme.primaryFontFamily,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 24.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "Recebimentos",
                                  style: TextStyle(
                                    color: Theme.deselectedBarItemTextColor,
                                    fontSize: Theme.warningFontSize,
                                    fontFamily: Theme.primaryFontFamily,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "R\$ 5.000,75",
                                  style: TextStyle(
                                      color: Theme.primaryHeaderColor,
                                      fontSize: Theme.twoItemsMenuFontSize,
                                      fontFamily: Theme.primaryFontFamily,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 40,
                              child: VerticalDivider(
                                color: Color(0xFFF2F2F2),
                                thickness: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Despesas",
                                  style: TextStyle(
                                    color: Theme.deselectedBarItemTextColor,
                                    fontSize: Theme.warningFontSize,
                                    fontFamily: Theme.primaryFontFamily,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "R\$ 800,00",
                                  style: TextStyle(
                                      color: Theme.primaryHeaderColor,
                                      fontSize: Theme.twoItemsMenuFontSize,
                                      fontFamily: Theme.primaryFontFamily,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
          ),
        ),
      ),
    );
  }
}