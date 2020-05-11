import 'package:flutter/material.dart';
import 'package:platy/core/widgets/Widgets.dart';
import 'package:platy/features/manage_transactions/domain/entities/Transaction.dart';
import 'package:platy/core/helpers/constants/style_constants.dart' as Theme;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreateTransactionDetails extends StatefulWidget {
  final Function(String, String, DateTime) callback;
  final Transaction transaction;
  CreateTransactionDetails({ this.callback, this.transaction });

  @override
  _CreateTransactionDetailsState createState() => _CreateTransactionDetailsState();
}

class _CreateTransactionDetailsState extends State<CreateTransactionDetails> {
  final FocusNode myFocusNodeDescription = FocusNode();
  final FocusNode myFocusNodeTarget = FocusNode();
  final FocusNode myFocusNodeDate = FocusNode();

  TextEditingController descriptionController = new TextEditingController();
  TextEditingController targetController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();

  var dateFormatter = new MaskTextInputFormatter(mask: '##/##/####', filter: { "#": RegExp(r'[0-9]') });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 80.0, left: 24.0, right: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Detalhes',
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
                  makeDescriptionText(widget.transaction.type),
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
            padding: EdgeInsets.only(top: 16.0, bottom: 4.0),
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: Theme.formFieldsStyle,
              height: 60.0,
              child: customInput(
                  inputType: TextInputType.text,
                  hintText: 'Descrição (Opcional)',
                  controller: descriptionController,
                  focusNode: myFocusNodeDescription,
                  nextFocus: myFocusNodeTarget,
                  context: context
              ), // CustomInput
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: Theme.formFieldsStyle,
              height: 60.0,
              child: customInput(
                  inputType: TextInputType.text,
                  hintText: makeTargetText(widget.transaction.type),
                  controller: targetController,
                  focusNode: myFocusNodeTarget,
                  nextFocus: myFocusNodeDate,
                  context: context
              ), // CustomInput
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Container(
              alignment: Alignment.centerLeft,
              decoration: Theme.formFieldsStyle,
              height: 60.0,
              child: customInputWithFormatter(
                  inputType: TextInputType.datetime,
                  inputFormatter: dateFormatter,
                  hintText: 'Data de vencimento (Opcional)',
                  controller: dateController,
                  focusNode: myFocusNodeDate,
                  context: context
              ), // CustomInput
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 24.0),
            height: 60,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(0.75, 0.0),
                      colors: [
                        Theme.gradientBegin,
                        Theme.gradientEnd
                      ]
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50.0),
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      Navigator.of(context).pushNamed('home');
                    },
                    child: Center(
                        child: customButton('Concluir')
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    myFocusNodeDescription.dispose();
    myFocusNodeTarget.dispose();
    myFocusNodeDate.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  makeDescriptionText(int type) {
    if(type == 1) {
      return 'Aqui você pode acrescentar uma descrição,\npara quem deseja pagar ou a data de\nvencimento da sua compra.';
    }
    return 'Aqui você pode acrescentar uma descrição,\nde quem está recebendo ou a data de\nrecebimento do valor.';
  }
  makeTargetText(int type) {
    if(type == 1) {
      return 'Pagar à (Opcional)';
    }
    return 'Recebido de (Opcional)';
  }
}