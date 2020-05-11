import 'package:flutter/material.dart';
import 'package:platy/features/manage_transactions/domain/entities/Transaction.dart';
import 'package:platy/core/helpers/constants/style_constants.dart' as Theme;

class CreateTransactionQuotas extends StatefulWidget {
  final Function(String) callback;
  final Transaction transaction;
  CreateTransactionQuotas({ this.callback, this.transaction });

  @override
  _CreateTransactionQuotasState createState() => _CreateTransactionQuotasState();
}

class _CreateTransactionQuotasState extends State<CreateTransactionQuotas> {
  final Map<String, Color> buttonUnique = {
    'backgroundColor': Theme.deselectedButtonBackgroundColor,
    'textColor': Theme.deselectedButtonTextColor
  };
  final Map<String, Color> buttonRecurring = {
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
                  'Tipo de transação',
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
                  'Selecione o tipo de transação:',
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
            padding: EdgeInsets.only(top: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 132,
                  height: 40,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color: buttonUnique['backgroundColor'],
                        border: Border.all(color: Theme.selectedButtonBackgroundColor),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50.0),
                          onTap: () => {
                            changeSelection("unique")
                          },
                          child: Center(
                            child: Text(
                              "Transação única",
                              style: TextStyle(
                                  color: buttonUnique['textColor'],
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
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 268,
                  height: 60,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color: buttonRecurring['backgroundColor'],
                        border: Border.all(color: Theme.selectedButtonBackgroundColor),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50.0),
                          onTap: () => {
                            changeSelection("n")
                          },
                          child: Center(
                            child: Text(
                              "Recorrente. Pode se repetir, como\naluguel ou salário, ou é uma parcela.",
                              style: TextStyle(
                                  color: buttonRecurring['textColor'],
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

  changeSelection(String quotas) {
    if(quotas == "unique") {
      widget.callback("unique");
      setState(() {
        buttonRecurring['backgroundColor'] = Theme.deselectedButtonBackgroundColor;
        buttonRecurring['textColor'] = Theme.deselectedButtonTextColor;
        buttonUnique['backgroundColor'] = Theme.selectedButtonBackgroundColor;
        buttonUnique['textColor'] = Theme.selectedButtonTextColor;
      });
    } else {
      widget.callback(quotas);
      setState(() {
        buttonUnique['backgroundColor'] = Theme.deselectedButtonBackgroundColor;
        buttonUnique['textColor'] = Theme.deselectedButtonTextColor;
        buttonRecurring['backgroundColor'] = Theme.selectedButtonBackgroundColor;
        buttonRecurring['textColor'] = Theme.selectedButtonTextColor;
      });
    }
  }

}
