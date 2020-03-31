import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:platy/Models/Transaction.dart';
import 'package:platy/Styles/Styles.dart' as Theme;

import 'CustomIcons.dart';

class TransactionListItem extends StatefulWidget {

  final Function onEdit;
  final Transaction transaction;
  final bool last;

  TransactionListItem({ this.onEdit, this.transaction, this.last });

  @override
  State<StatefulWidget> createState() => _TransactionListItemState();
}

class _TransactionListItemState extends State<TransactionListItem>{
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: widget.transaction.status ? Color(0xFF1ABC9C) : Colors.white,
                                borderRadius: BorderRadius.circular(50.0),
                                border: new Border.all(
                                    color: Color(0xFFD4D4D4),
                                    width: 1.0,
                                    style: BorderStyle.solid
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !widget.last,
                            child: Container(
                              height: 60,
                              child: VerticalDivider(
                                color: Color(0xFFF2F2F2),
                                thickness: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    "R\$ " + widget.transaction.value.toString(),
                                    style: TextStyle(
                                        fontSize: Theme.twoItemsMenuFontSize,
                                        fontFamily: Theme.primaryFontFamily,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.transactionValueText
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 2.0),
                                  child: Text(
                                    widget.transaction.description,
                                    style: TextStyle(
                                      color: Theme.hintTextColor,
                                      fontSize: Theme.warningFontSize,
                                      fontFamily: Theme.primaryFontFamily,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          widget.transaction.date.day.toString() + '/' + widget.transaction.date.month.toString() + '/' + widget.transaction.date.year.toString(),
                                          style: TextStyle(
                                            color: Theme.hintTextColor,
                                            fontSize: Theme.warningFontSize,
                                            fontFamily: Theme.primaryFontFamily,
                                          ),
                                        ),
                                        Text(
                                          ' - ',
                                          style: TextStyle(
                                            color: Theme.hintTextColor,
                                            fontSize: Theme.warningFontSize,
                                            fontFamily: Theme.primaryFontFamily,
                                          ),
                                        ),
                                        Text(
                                          widget.transaction.target,
                                          style: TextStyle(
                                            color: Theme.hintTextColor,
                                            fontSize: Theme.warningFontSize,
                                            fontFamily: Theme.primaryFontFamily,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 24.0, bottom: 22.0),
                                  child: SizedBox(
                                    height: 22.0,
                                    width: 22.0,
                                    child:
                                    IconButton(
                                      icon: Icon(CSIcons.edit, color: Theme.linkTextColor, size: Theme.inputIconSize),
                                      padding: EdgeInsets.only(right: 24.0),
                                      onPressed: (){
                                        widget.onEdit();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    widget.transaction.category,
                                    style: TextStyle(
                                      color: Theme.hintTextColor,
                                      fontSize: Theme.warningFontSize,
                                      fontFamily: Theme.primaryFontFamily,
                                    ),
                                  ),
                                ],
                              ),),
                          ],
                        ),
                      )
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  }
