import 'package:flutter/material.dart';
import 'package:platy/features/manage_transactions/domain/entities/Transaction.dart';
import 'package:platy/features/manage_transactions/presentation/pages/create_transaction/transaction_details/transaction_details_screen.dart';
import 'package:platy/features/manage_transactions/presentation/pages/create_transaction/transaction_quotas/transaction_quotas_screen.dart';
import 'package:platy/features/manage_transactions/presentation/pages/create_transaction/transaction_status/transaction_status_screen.dart';
import 'package:platy/features/manage_transactions/presentation/pages/create_transaction/transaction_type/transaction_type_screen.dart';
import 'dart:core';

import 'package:platy/features/manage_transactions/presentation/pages/create_transaction/transaction_value/transaction_value_screen.dart';

class CreateTransaction extends StatefulWidget {
  @override
  _CreateTransactionState createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final PageController pageController = PageController(initialPage: 0);
  final Transaction createdTransaction = new Transaction();

  @override
  Widget build(BuildContext context) {

    var lista = [
      CreateTransactionType(callback: changeTransactionType, transaction: createdTransaction),
      CreateTransactionQuotas(callback: changeTransactionQuotas, transaction: createdTransaction),
      CreateTransactionStatus(callback: changeTransactionStatus, transaction: createdTransaction),
      CreateTransactionValue(callback: changeTransactionValue, transaction: createdTransaction),
      CreateTransactionDetails(callback: changeTransactionDetails, transaction: createdTransaction),
    ];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: PageView.builder(
                physics:new NeverScrollableScrollPhysics(),
                controller: pageController,
                itemCount: lista.length,
                itemBuilder: (ctx, i) => lista[i]
            ),
          ),
        ],
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  changeTransactionType(int type) {
    pageController.animateToPage(1, duration: Duration(milliseconds: 1000), curve: Curves.decelerate);
    setState(() {
      createdTransaction.type = type;
    });
  }

  changeTransactionQuotas(String quotas) {
    pageController.animateToPage(2, duration: Duration(milliseconds: 1000), curve: Curves.decelerate);
    setState(() {
      createdTransaction.quotas = quotas;
    });
  }

  changeTransactionStatus(bool status) {
    pageController.animateToPage(3, duration: Duration(milliseconds: 1000), curve: Curves.decelerate);
    setState(() {
      createdTransaction.status = status;
    });
  }

  changeTransactionValue(double value, String quotas) {
    pageController.animateToPage(4, duration: Duration(milliseconds: 1000), curve: Curves.decelerate);
    setState(() {
      createdTransaction.value = value;
      createdTransaction.quotas = quotas;
    });
  }

  changeTransactionDetails(String description, String target, DateTime date) {
    setState(() {
      createdTransaction.description = description;
      createdTransaction.target = target;
      createdTransaction.date = date;
    });
  }

}
