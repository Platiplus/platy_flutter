import 'package:flutter/material.dart';
import 'package:platy/core/helpers/constants/style_constants.dart' as Theme;
import 'package:platy/core/helpers/constants/utilities_constants.dart';
import 'package:platy/core/widgets/Widgets.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionCreateModel.dart';

class CreateTransactionValue extends StatefulWidget {
  final Function(double, String) callback;
  final TransactionCreateModel transaction;
  CreateTransactionValue({ this.callback, this.transaction });

  @override
  _CreateTransactionValueState createState() => _CreateTransactionValueState();
}

class _CreateTransactionValueState extends State<CreateTransactionValue> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey _tooltipKey = new GlobalKey();
  final FocusNode myFocusNodeValue = FocusNode();
  final List<DropdownMenuItem<int>> nQuotas = new List<DropdownMenuItem<int>>();

  bool isNumberValid = true;
  bool isQuotasValid = true;

  int _selectedNQuotas;

  TextEditingController valueController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Padding(
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
                    makeTitleText(widget.transaction.quotas),
                    style: TextStyle(
                        fontSize: Theme.supportHeadersSize,
                        fontFamily: Theme.primaryFontFamily,
                        color: Theme.supportHeadersTextColor,
                        fontWeight: Theme.supportHeadersFontWeight
                    ),
                  ),
                  Visibility(
                    visible: widget.transaction.quotas != 'unique',
                    child: GestureDetector(
                      onTap: () async {
                        final dynamic tooltip = _tooltipKey.currentState;
                        tooltip.ensureTooltipVisible();
                        await Future.delayed(const Duration(seconds: 2), (){});
                        tooltip.deactivate();
                      },
                      child: Tooltip(
                        key: _tooltipKey,
                        child: IconButton(
                            icon: Icon(CSIcons.clarify, color: Theme.inputSelectableIconColor, size: Theme.inputIconSize)
                        ),
                        message: 'Por enquanto o número máximo de repetições é 12. Estamos testando a possibilidade de aumentar a recorrência.',
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.inputSelectableIconColor.withOpacity(0.9),
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                        ),
                        textStyle: TextStyle(color: Colors.white),
                        preferBelow: true,
                        verticalOffset: 5,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    makeDescriptionText(widget.transaction.quotas),
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
                    inputType: TextInputType.number,
                    hintText: makeHintText(widget.transaction.quotas),
                    controller: valueController,
                    focusNode: myFocusNodeValue,
                    context: context
                ), // CustomInput
              ),
            ),
            Visibility(
              visible: !isNumberValid,
              child:
              Padding(
                padding: EdgeInsets.only(bottom: 5.0, left: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Preencha ou verifique o valor',
                      style: TextStyle(
                          fontFamily: Theme.primaryFontFamily,
                          fontSize: Theme.errorFeedbackFontSize,
                          color: Theme.errorFeedbackColor
                      ),
                    ),
                  ],
                )
              ),
            ),
            Visibility(
              visible: widget.transaction.quotas != 'unique',
              child: Padding(
                padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Container(
                    alignment: Alignment.centerRight,
                    decoration: Theme.formFieldsStyle,
                    height: 60.0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: DropdownButton(
                        hint: Text('Quantas vezes se repete'),
                        underline: SizedBox(),
                        isExpanded: true,
                        style: TextStyle(
                          color: Theme.dirtyInputTextColor,
                          fontSize: Theme.inputFontSize,
                        ),
                        icon: Icon(CSIcons.arrow_down, color: Theme.inputSelectableIconColor, size: Theme.inputIconSize),
                        value: _selectedNQuotas,
                        items: nQuotas,
                        onChanged: onChangeDropdownItem,
                      ),
                    )
                ),
              ),
            ),
            Visibility(
              visible: !isQuotasValid,
              child:
              Padding(
                padding: EdgeInsets.only(bottom: 5.0, left: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Preencha o número de repetições.',
                      style: TextStyle(
                          fontFamily: Theme.primaryFontFamily,
                          fontSize: Theme.errorFeedbackFontSize,
                          color: Theme.errorFeedbackColor
                      ),
                    ),
                  ],
                )
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
                        onSubmit(valueController.text, _selectedNQuotas);
                      },
                      child: Center(
                          child: customButton('Próximo')
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    myFocusNodeValue.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _buildDropdown();
    super.initState();
  }

  makeDescriptionText(String quotas) {
    if(quotas == 'unique') {
      return 'Insira o valor da transação';
    }
    return 'Insira o valor e a recorrência da transação';
  }

  makeHintText(String quotas) {
    if(quotas == 'unique') {
      return 'Valor da transação';
    }
    return 'Valor da parcela ou custo recorrente';
  }

  makeTitleText(String quotas) {
    if(quotas == 'unique') {
      return 'Valor';
    }
    return 'Valor e recorrência';
  }

  _buildDropdown() {
    for (var idx = 1; idx <= 12; idx++) {
      nQuotas.add(
          DropdownMenuItem(
              value: idx,
              child: Text(idx.toString())
          )
      ) ;
    }
  }

  onChangeDropdownItem(int item) {
    setState(() {
      _selectedNQuotas = item;
    });
  }

  onSubmit(String value, int quotas) {
    numberValidation(value);
    quotasValidation(quotas);

    if (isNumberValid && isQuotasValid) {
      if(brNumberRegex.hasMatch(value)) value = value.split(',').join('.');

      if(widget.transaction.quotas != 'unique') {
        widget.callback(double.parse(value), resolveQuotas(quotas));
      } else {
        widget.callback(double.parse(value), widget.transaction.quotas);
      }
    }
  }

  numberValidation(String value) {
    bool valid;

    if(brNumberRegex.hasMatch(value)) value = value.split(',').join('.');

    if(value.isNotEmpty && numberRegex.hasMatch(value)) {
      valid = true;
    } else {
      valid = false;
    }

    setState(() {
      isNumberValid = valid;
    });
  }

  quotasValidation(int quotas) {
    bool valid;

    if(widget.transaction.quotas != 'unique' && quotas == null) {
      valid = false;
    } else {
      valid = true;
    }

    setState(() {
      isQuotasValid = valid;
    });
  }

  resolveQuotas(int quotas) {
    if(quotas != null) {
      return quotas.toString();
    }
    return 'unique';
  }
}
