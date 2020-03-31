// FLUTTER DEPENDENCIES
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:platy/Models/Transaction.dart';
import 'package:platy/Utils/endpoint_constants.dart';
import 'package:platy/Widgets/Widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// EXTERNAL DEPENDENCIES
import 'package:platy/Styles/Styles.dart' as Theme;
import 'package:platy/Utils/painter_constants.dart';
import 'package:platy/Widgets/CustomIcons.dart';
import 'package:platy/Widgets/TransactionItem.dart';

class Control extends StatefulWidget {
  Control({Key key}) : super(key: key);

  @override
  ControlState createState() => new ControlState();
}

class ControlState extends State<Control> {

  PageController _pageController;
  Color leftMenuTextColor = Theme.selectedBarItemTextColor;
  Color centerMenuTextColor = Theme.deselectedBarItemTextColor;
  Color rightMenuTextColor = Theme.deselectedBarItemTextColor;

  List<Transaction> variableOutcomeTransactions = [];
  List<Transaction> fixedOutcomeTransactions = [];
  List<Transaction> incomeTransactions = [];
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);


    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 60.0, left: 30.0, bottom: 20.0),
                  child: GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Text(
                          'FEVEREIRO',
                          style: TextStyle(
                            fontSize: Theme.header2FontSize,
                            fontFamily: Theme.primaryFontFamily,
                            color: Theme.monthMenuColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Icon(CSIcons.arrow_down, color: Theme.linkTextColor, size: Theme.inputIconSize),
                        ),
                      ],
                    )
                  ),
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Text(
                        "R\$ 0,00",
                        style: TextStyle(
                          color: Theme.primaryHeaderColor,
                          fontSize: Theme.header1FontSize,
                          fontFamily: Theme.primaryFontFamily,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: GestureDetector(
                        child: Material(
                          child: Ink(
                            height: 24.0,
                            width: 24.0,
                            decoration: ShapeDecoration(
                              color: Theme.linkTextColor,
                              shape: CircleBorder(),
                            ),
                            child: Icon(
                              CSIcons.cta_add,
                              color: Colors.white,
                              size: 14.0,
                            ),
                          ),
                        ),
                        onTap: (){
                          print('ADICIONAR TRANSACAO ATIVADO');
                        },
                      )
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.0, left: 30.0),
                  child: Text(
                    "Balanço do mês",
                    style: TextStyle(
                      color: Theme.deselectedBarItemTextColor,
                      fontSize: Theme.warningFontSize,
                      fontFamily: Theme.primaryFontFamily,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2, left: 240),
                  child: Container(
                    height: 40,
                    child: VerticalDivider(
                      color: Color(0xFFF2F2F2),
                      thickness: 1.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 270),
                  child: FlatButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed('home-details');
                    },
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      "Ver detalhes",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.linkTextColor,
                        fontSize: Theme.warningFontSize,
                        fontFamily: Theme.primaryFontFamily,
                      ),
                    ),
                  )
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Container(
                width: 348.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: CustomPaint(
                  painter: TabIndicationPainterThreeItems(pageController: _pageController),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: _onVariableOutcomeButtonPress,
                          child: Text(
                            "Gasto Variável",
                            style: TextStyle(
                                color: leftMenuTextColor,
                                fontSize: Theme.threeItemsMenuFontSize,
                                fontFamily: Theme.primaryFontFamily,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FlatButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: _onFixedOutcomeButtonPress,
                          child: Text(
                            "Gasto Fixo",
                            style: TextStyle(
                                color: centerMenuTextColor,
                                fontSize: Theme.threeItemsMenuFontSize,
                                fontFamily: Theme.primaryFontFamily,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FlatButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: _onIncomeButtonPress,
                          child: Text(
                            "Recebimento",
                            style: TextStyle(
                                color: rightMenuTextColor,
                                fontSize: Theme.threeItemsMenuFontSize,
                                fontFamily: Theme.primaryFontFamily,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) {
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  changeMenuTextColors(i);
                },
                children: <Widget>[
                  new ConstrainedBox(
                    constraints: const BoxConstraints.expand(),
                    child: variableOutcomeTransactions.length == 0
                        ?
                    Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Column(
                        children: <Widget>[
                          !_loading ? noTransactions() : Container(),
                          Visibility(
                            visible: _loading,
                            child: _loading ? CircularProgressIndicator() : Container(),
                          ),
                        ],
                      ),
                    )
                        :
                    ListView.builder(
                      itemBuilder: (_, index) {
                        var transaction = variableOutcomeTransactions[index];
                        TransactionListItem listItem = new TransactionListItem(
                          transaction: transaction,
                          onEdit: (){
                            setState(() {
                              transaction.value = 1235;
                              variableOutcomeTransactions[index] = transaction;
                            });
                          },
                        );
                        return listItem;
                      },
                      itemCount: variableOutcomeTransactions.length,
                    ),
                  ),
                  new ConstrainedBox(
                    constraints: const BoxConstraints.expand(),
                    child: ListView.builder(
                      itemBuilder: (_, index) {
                        var transaction = fixedOutcomeTransactions[index];
                        TransactionListItem listItem = new TransactionListItem(
                          transaction: transaction,
                          onEdit: (){
                            setState(() {
                              transaction.value = 1235;
                              fixedOutcomeTransactions[index] = transaction;
                            });
                          },
                        );
                        return listItem;
                      },
                      itemCount: fixedOutcomeTransactions.length,
                    ),
                  ),
                  new ConstrainedBox(
                    constraints: const BoxConstraints.expand(),
                    child: ListView.builder(
                      itemBuilder: (_, index) {
                        var transaction = incomeTransactions[index];
                        TransactionListItem listItem = new TransactionListItem(
                          transaction: transaction,
                          onEdit: (){
                            setState(() {
                              transaction.value = 1235;
                              incomeTransactions[index] = transaction;
                            });
                          },
                        );
                        return listItem;
                      },
                      itemCount: incomeTransactions.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  //STATE MANAGEMENT
  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
    fillTransactionsList();
  }

  void _onVariableOutcomeButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 800), curve: Curves.decelerate);
  }

  void _onFixedOutcomeButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 800), curve: Curves.decelerate);
  }

  void _onIncomeButtonPress() {
    _pageController?.animateToPage(2,
        duration: Duration(milliseconds: 800), curve: Curves.decelerate);
  }

  void changeMenuTextColors(i){
    if (i == 0) {
      setState(() {
        rightMenuTextColor = Theme.deselectedBarItemTextColor;
        centerMenuTextColor = Theme.deselectedBarItemTextColor;
        leftMenuTextColor = Theme.selectedBarItemTextColor;
      });
    } else if (i == 1) {
      setState(() {
        rightMenuTextColor = Theme.deselectedBarItemTextColor;
        centerMenuTextColor = Theme.selectedBarItemTextColor;
        leftMenuTextColor = Theme.deselectedBarItemTextColor;
      });
    } else if (i == 2) {
      setState(() {
        rightMenuTextColor = Theme.selectedBarItemTextColor;
        centerMenuTextColor = Theme.deselectedBarItemTextColor;
        leftMenuTextColor = Theme.deselectedBarItemTextColor;
      });
    }
  }

  void fillTransactionsList() async {

    setState(() {
      _loading = true;
    });

    var token;
    Map<String, List<Transaction>> list = {
      "variable_outcome" : [],
      "fixed_outcome": [],
      "income": []
    };

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('accessToken');

    var response = await http.get(getTransactionsUrl, headers: { 'authorization': 'Bearer ' + token });

    if(response.statusCode == 200) {
      var jsonList = json.decode(response.body) as List;
      List<Transaction> transactions = jsonList.map((t) => Transaction.fromJson(t)).toList();

      transactions.forEach((transaction){
        switch(transaction.type){
          case 1:
            list['income'].add(transaction);
            break;
          case 2:
            list['variable_outcome'].add(transaction);
            break;
          case 3:
            list['fixed_outcome'].add(transaction);
            break;
        }
      });
    }

    setState(() {
      variableOutcomeTransactions = list["variable_outcome"];
      fixedOutcomeTransactions = list["fixed_outcome"];
      incomeTransactions = list["income"];
      _loading = false;
    });
  }

}