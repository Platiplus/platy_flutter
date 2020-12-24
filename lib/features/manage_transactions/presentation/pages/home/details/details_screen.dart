import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platy/core/widgets/Widgets.dart';
import 'package:platy/features/manage_transactions/presentation/widgets/Widgets.dart';
import 'package:platy/core/helpers/constants/style_constants.dart' as Theme;
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';
import "package:collection/collection.dart";
import "package:platy/features/manage_transactions/data/enums/Categories.dart";
import "package:platy/core/helpers/constants/utilities_constants.dart";

class HomeDetails extends StatefulWidget {
  HomeDetails({Key key, this.transactions}) : super(key: key);

  final List<List<TransactionModel>> transactions;

  @override
  HomeDetailsState createState() => new HomeDetailsState();
}

class HomeDetailsState extends State<HomeDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final Map<String, Map<String, double>> spendingsByCategory = defineCategories(widget.transactions);
    final totals = getTotals(widget.transactions);
    final zeroTransactions = widget.transactions.length == 0;

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
                      color: Theme.inputSelectableIconColor,
                    ),
                ),
                zeroTransactions ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Column(
                            children: <Widget>[
                              noTransactions()
                            ],
                          ),
                        ),
                      ],
                    ) : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Balanço do mês",
                          style: TextStyle(
                            color: Theme.controlMenuDeselectedBarItemTextColor,
                            fontSize: Theme.errorFeedbackFontSize,
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
                                color: Theme.moneyBalanceTextColor,
                                fontSize: Theme.supportFontSize,
                                fontFamily: Theme.primaryFontFamily,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Text(
                          currencyFormatterNoSymbol.format(totals["total"]),
                          style: TextStyle(
                              color: Theme.moneyBalanceTextColor,
                              fontSize: Theme.moneyBalanceFontSize,
                              fontFamily: Theme.primaryFontFamily,
                              fontWeight: Theme.moneyBalanceFontWeight
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
                                        color: Theme.supportTextColor,
                                        fontSize: Theme.supportFontSize,
                                        fontFamily: Theme.primaryFontFamily,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      currencyFormatter.format(totals['incomes']),
                                      style: TextStyle(
                                          color: Theme.moneyValueTextColor,
                                          fontSize: Theme.moneyValueFontSize,
                                          fontFamily: Theme.primaryFontFamily,
                                          fontWeight: Theme.moneyBalanceFontWeight
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
                                    color: Theme.dividerColor,
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
                                        color: Theme.supportTextColor,
                                        fontSize: Theme.supportFontSize,
                                        fontFamily: Theme.primaryFontFamily,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      currencyFormatter.format(totals["outcomes"]),
                                      style: TextStyle(
                                          color: Theme.moneyValueTextColor,
                                          fontSize: Theme.moneyValueFontSize,
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
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child:Divider(
                            height: 50.0,
                            indent: 40.0,
                            endIndent: 40.0,
                            thickness: 1.0,
                            color: Color(0xFFEEEEEE),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Maiores gastos",
                            style: TextStyle(
                                color: Theme.moneyValueTextColor,
                                fontSize: Theme.moneyValueFontSize,
                                fontFamily: Theme.primaryFontFamily,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 7.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(40.0, 13.0, 10.0, 13.0),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Icon(CSIcons.health, size: 24, color: Color(0xFF223254))
                                      ]
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 13.0, bottom: 13.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                            width: 200,
                                            child: HorizontalProgressIndicator(endAnimation: spendingsByCategory[Categories.HABITACAO.name]["percentage"])
                                        )
                                    )
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(10.0, 13.0, 40.0, 13.0),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            currencyFormatter.format(spendingsByCategory[Categories.HABITACAO.name]["spendings"]),
                                            style: TextStyle(
                                              color: Theme.supportTextColor,
                                              fontSize: Theme.supportFontSize,
                                              fontFamily: Theme.primaryFontFamily,
                                            ),
                                          ),
                                        ]
                                    )
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(40.0, 13.0, 10.0, 13.0),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Icon(CSIcons.health, size: 24, color: Color(0xFF223254))
                                      ]
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 13.0, bottom: 13.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                            width: 200,
                                            child: HorizontalProgressIndicator(endAnimation: spendingsByCategory[Categories.LAZER.name]["percentage"])
                                        )
                                    )
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(10.0, 13.0, 0.0, 13.0),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            currencyFormatter.format(spendingsByCategory[Categories.LAZER.name]["spendings"]),
                                            style: TextStyle(
                                              color: Theme.supportTextColor,
                                              fontSize: Theme.supportFontSize,
                                              fontFamily: Theme.primaryFontFamily,
                                            ),
                                          ),
                                        ]
                                    )
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(40.0, 13.0, 10.0, 13.0),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Icon(CSIcons.health, size: 24, color: Color(0xFF223254))
                                      ]
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 13.0, bottom: 13.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                            width: 200,
                                            child: HorizontalProgressIndicator(endAnimation: spendingsByCategory[Categories.TRANSPORTE.name]["percentage"])
                                        )
                                    )
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(10.0, 13.0, 0.0, 13.0),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            currencyFormatter.format(spendingsByCategory[Categories.TRANSPORTE.name]["spendings"]),
                                            style: TextStyle(
                                              color: Theme.supportTextColor,
                                              fontSize: Theme.supportFontSize,
                                              fontFamily: Theme.primaryFontFamily,
                                            ),
                                          ),
                                        ]
                                    )
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(40.0, 13.0, 10.0, 13.0),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Icon(CSIcons.health, size: 24, color: Color(0xFF223254))
                                      ]
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 13.0, bottom: 13.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                            width: 200,
                                            child: HorizontalProgressIndicator(endAnimation: spendingsByCategory[Categories.COMPRAS.name]["percentage"])
                                        )
                                    )
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(10.0, 13.0, 40.0, 13.0),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            currencyFormatter.format(spendingsByCategory[Categories.COMPRAS.name]["spendings"]),
                                            style: TextStyle(
                                              color: Theme.supportTextColor,
                                              fontSize: Theme.supportFontSize,
                                              fontFamily: Theme.primaryFontFamily,
                                            ),
                                          ),
                                        ]
                                    )
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(40.0, 13.0, 10.0, 13.0),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Icon(CSIcons.health, size: 24, color: Color(0xFF223254))
                                      ]
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 13.0, bottom: 13.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                            width: 200,
                                            child: HorizontalProgressIndicator(endAnimation: spendingsByCategory[Categories.CONTAS.name]["percentage"])
                                        )
                                    )
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(10.0, 13.0, 40.0, 13.0),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            currencyFormatter.format(spendingsByCategory[Categories.CONTAS.name]["spendings"]),
                                            style: TextStyle(
                                              color: Theme.supportTextColor,
                                              fontSize: Theme.supportFontSize,
                                              fontFamily: Theme.primaryFontFamily,
                                            ),
                                          ),
                                        ]
                                    )
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(40.0, 13.0, 10.0, 13.0),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Icon(CSIcons.health, size: 24, color: Color(0xFF223254))
                                      ]
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 13.0, bottom: 13.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                            width: 200,
                                            child: HorizontalProgressIndicator(endAnimation: spendingsByCategory[Categories.ALIMENTACAO.name]["percentage"])
                                        )
                                    )
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(10.0, 13.0, 40.0, 13.0),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            currencyFormatter.format(spendingsByCategory[Categories.ALIMENTACAO.name]["spendings"]),
                                            style: TextStyle(
                                              color: Theme.supportTextColor,
                                              fontSize: Theme.supportFontSize,
                                              fontFamily: Theme.primaryFontFamily,
                                            ),
                                          ),
                                        ]
                                    )
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(40.0, 13.0, 10.0, 13.0),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Icon(CSIcons.health, size: 24, color: Color(0xFF223254))
                                      ]
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 13.0, bottom: 13.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                            width: 200,
                                            child: HorizontalProgressIndicator(endAnimation: spendingsByCategory[Categories.OUTROS.name]["percentage"])
                                        )
                                    )
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(10.0, 13.0, 40.0, 13.0),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            currencyFormatter.format(spendingsByCategory[Categories.OUTROS.name]["spendings"]),
                                            style: TextStyle(
                                              color: Theme.supportTextColor,
                                              fontSize: Theme.supportFontSize,
                                              fontFamily: Theme.primaryFontFamily,
                                            ),
                                          ),
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ],
          ),
        ),
      ),
    );
  }

  getTotals(List<List<TransactionModel>> transactions) {
    List<TransactionModel> outcomesList = new List<TransactionModel>();
    List<TransactionModel> incomesList = new List<TransactionModel>();

    if(transactions.length != 0) {
      outcomesList.addAll(transactions.elementAt(0));
      incomesList.addAll(transactions.elementAt(1));
    }

    var totalSpendings = outcomesList.length != 0 ? outcomesList.map<double>((spend) => spend.value).reduce((s1, s2) => s1 + s2) : 0.0;
    var totalIncomes = incomesList.length != 0 ? incomesList.map<double>((spend) => spend.value).reduce((s1, s2) => s1 + s2) : 0.0;

    Map<String, double> totals = {
      "total": totalIncomes - totalSpendings,
      "outcomes" : totalSpendings,
      "incomes" :totalIncomes
    };

    return totals;
  }

  defineCategories(List<List<TransactionModel>> transactions) {
    List<TransactionModel> transactionsList = new List<TransactionModel>();

    var totalSpendings = 0.0;
    var habitacaoSpendings = 0.0;
    var lazerSpendings = 0.0;
    var manutencaoSpendings = 0.0;
    var taxasBancariasSpendings = 0.0;
    var contasDaCasaSpendings = 0.0;
    var saudeSpendings = 0.0;
    var outrosSpendings = 0.0;

    if(transactions.length != 0) {
      transactionsList.addAll(transactions.elementAt(0));
      totalSpendings = transactionsList.map<double>((spend) => spend.value).reduce((s1, s2) => s1 + s2);
    }

    habitacaoSpendings = getValueByCategory(transactionsList, Categories.HABITACAO.name);
    lazerSpendings = getValueByCategory(transactionsList, Categories.LAZER.name);
    manutencaoSpendings = getValueByCategory(transactionsList, Categories.TRANSPORTE.name);
    taxasBancariasSpendings = getValueByCategory(transactionsList, Categories.COMPRAS.name);
    contasDaCasaSpendings = getValueByCategory(transactionsList, Categories.CONTAS.name);
    saudeSpendings = getValueByCategory(transactionsList, Categories.ALIMENTACAO.name);
    outrosSpendings = getValueByCategory(transactionsList, Categories.OUTROS.name);

    Map<String, Map<String, double>> spendingsByCategory = {
      Categories.HABITACAO.name: {
        "percentage": ((habitacaoSpendings * 100) / totalSpendings) / 100,
        "spendings": habitacaoSpendings
      },
      Categories.LAZER.name: {
        "percentage": ((lazerSpendings * 100) / totalSpendings) / 100,
        "spendings": lazerSpendings
      },
      Categories.TRANSPORTE.name: {
        "percentage": ((manutencaoSpendings * 100) / totalSpendings) / 100,
        "spendings": manutencaoSpendings
      },
      Categories.COMPRAS.name: {
        "percentage": ((taxasBancariasSpendings * 100) / totalSpendings) / 100,
        "spendings": taxasBancariasSpendings
      },
      Categories.CONTAS.name: {
        "percentage": ((contasDaCasaSpendings * 100) / totalSpendings) / 100,
        "spendings": contasDaCasaSpendings
      },
      Categories.ALIMENTACAO.name: {
        "percentage": ((saudeSpendings * 100) / totalSpendings) / 100,
        "spendings": saudeSpendings
      },
      Categories.OUTROS.name: {
        "percentage": ((outrosSpendings * 100) / totalSpendings) / 100,
        "spendings": outrosSpendings
      },
    };

    return spendingsByCategory;
  }

  getValueByCategory(List<TransactionModel> transactionsList, String category) {
    var transactionsByCategories = groupBy(transactionsList, (transaction) => transaction.category);

    return transactionsByCategories[category] != null
        ? transactionsByCategories[category].map<double>((spend) => spend.value).reduce((s1, s2) => s1 + s2)
        : 0.0;
  }
}