import 'package:flutter/material.dart';
import 'package:platy/core/helpers/constants/style_constants.dart' as Theme;
import 'package:platy/features/manage_transactions/domain/entities/Transaction.dart';

class CreateTransactionStatus extends StatefulWidget {
  final Function(bool) callback;
  final Transaction transaction;
  CreateTransactionStatus({ this.callback, this.transaction });

  @override
  _CreateTransactionStatusState createState() => _CreateTransactionStatusState(this.transaction.type);
}

class _CreateTransactionStatusState extends State<CreateTransactionStatus> {
  final Map<String, Color> buttonYes = {
    'backgroundColor': Theme.deselectedButtonBackgroundColor,
    'textColor': Theme.deselectedButtonTextColor
  };
  final Map<String, Color> buttonNo = {
    'backgroundColor': Theme.deselectedButtonBackgroundColor,
    'textColor': Theme.deselectedButtonTextColor
  };

  int transactionType;

  _CreateTransactionStatusState(int type) {
    transactionType = type;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 80.0, left: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Status da transação',
                  style: TextStyle(
                      fontSize: Theme.supportHeadersSize,
                      fontFamily: Theme.primaryFontFamily,
                      color: Theme.supportHeadersTextColor,
                      fontWeight: Theme.supportHeadersFontWeight
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  makeDescriptionText(transactionType),
                  style: TextStyle(
                    fontSize: Theme.behaviorDescriptionFontSize,
                    fontFamily: Theme.primaryFontFamily,
                    color: Theme.behaviorDescriptionTextColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 128,
                  height: 40,
                  margin: EdgeInsets.only(right: 8),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color: buttonYes['backgroundColor'],
                        border: Border.all(color: Theme.selectedButtonBackgroundColor),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50.0),
                          onTap: () => {
                            changeSelection(true)
                          },
                          child: Center(
                            child: Text(
                              "Sim",
                              style: TextStyle(
                                  color: buttonYes['textColor'],
                                  fontSize: Theme.supportButtonsFontSize,
                                  fontFamily: Theme.primaryFontFamily,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 128,
                  height: 40,
                  margin: EdgeInsets.only(left: 8),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color: buttonNo['backgroundColor'],
                        border: Border.all(color: Theme.selectedButtonBackgroundColor),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50.0),
                          onTap: () => {
                            changeSelection(false)
                          },
                          child: Center(
                            child: Text(
                              "Não",
                              style: TextStyle(
                                  color: buttonNo['textColor'],
                                  fontSize: Theme.supportButtonsFontSize,
                                  fontFamily: Theme.primaryFontFamily,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  changeSelection(bool status) {
    if (status) {
      widget.callback(true);
      setState(() {
        buttonNo['backgroundColor'] = Theme.deselectedButtonBackgroundColor;
        buttonNo['textColor'] = Theme.deselectedButtonTextColor;
        buttonYes['backgroundColor'] = Theme.selectedButtonBackgroundColor;
        buttonYes['textColor'] = Theme.selectedButtonTextColor;
      });
    } else {
      widget.callback(false);
      setState(() {
        buttonYes['backgroundColor'] = Theme.deselectedButtonBackgroundColor;
        buttonYes['textColor'] = Theme.deselectedButtonTextColor;
        buttonNo['backgroundColor'] = Theme.selectedButtonBackgroundColor;
        buttonNo['textColor'] = Theme.selectedButtonTextColor;
      });
    }
  }
  makeDescriptionText(int type) {
    if (type == 1) {
      return 'Essa conta já foi paga?';
    }
    return 'Essa conta já foi recebida?';
  }
}
