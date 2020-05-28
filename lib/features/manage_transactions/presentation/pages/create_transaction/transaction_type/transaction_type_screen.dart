import 'package:flutter/material.dart';
import 'package:platy/core/helpers/constants/style_constants.dart' as Theme;
import 'package:platy/features/manage_transactions/data/enums/TransactionType.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionCreateModel.dart';

class CreateTransactionType extends StatefulWidget {
  final Function(int) callback;
  final TransactionCreateModel transaction;
  CreateTransactionType({ this.callback, this.transaction });

  @override
  _CreateTransactionTypeState createState() => _CreateTransactionTypeState();
}

class _CreateTransactionTypeState extends State<CreateTransactionType> {
  final Map<String, Color> buttonGasto = {
    'backgroundColor': Theme.deselectedButtonBackgroundColor,
    'textColor': Theme.deselectedButtonTextColor
  };
  final Map<String, Color> buttonRecebimento = {
    'backgroundColor': Theme.deselectedButtonBackgroundColor,
    'textColor': Theme.deselectedButtonTextColor
  };

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
                  'Nova transação',
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
                  'Selecione qual transação que deseja inserir',
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
                  width: 76,
                  height: 40,
                  margin: EdgeInsets.only(right: 8),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color: buttonGasto['backgroundColor'],
                        border: Border.all(color: Theme.selectedButtonBackgroundColor),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50.0),
                          onTap: () => {
                            changeSelection(TransactionType.GASTO)
                          },
                          child: Center(
                            child: Text(
                              "Gasto",
                              style: TextStyle(
                                  color: buttonGasto['textColor'],
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
                  width: 132,
                  height: 40,
                  margin: EdgeInsets.only(left: 8),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color: buttonRecebimento['backgroundColor'],
                        border: Border.all(color: Theme.selectedButtonBackgroundColor),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50.0),
                          onTap: () => {
                            changeSelection(TransactionType.RECEBIMENTO)
                          },
                          child: Center(
                            child: Text(
                              "Recebimento",
                              style: TextStyle(
                                  color: buttonRecebimento['textColor'],
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

  changeSelection(int type) {
    if(type == TransactionType.GASTO) {
      widget.callback(1);
      setState(() {
        buttonRecebimento['backgroundColor'] = Theme.deselectedButtonBackgroundColor;
        buttonRecebimento['textColor'] = Theme.deselectedButtonTextColor;
        buttonGasto['backgroundColor'] = Theme.selectedButtonBackgroundColor;
        buttonGasto['textColor'] = Theme.selectedButtonTextColor;
      });
    } else {
      widget.callback(TransactionType.RECEBIMENTO);
      setState(() {
        buttonGasto['backgroundColor'] = Theme.deselectedButtonBackgroundColor;
        buttonGasto['textColor'] = Theme.deselectedButtonTextColor;
        buttonRecebimento['backgroundColor'] = Theme.selectedButtonBackgroundColor;
        buttonRecebimento['textColor'] = Theme.selectedButtonTextColor;
      });
    }
  }
}
