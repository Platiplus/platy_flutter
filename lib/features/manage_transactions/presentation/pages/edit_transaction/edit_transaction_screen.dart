import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:platy/core/helpers/constants/utilities_constants.dart';
import 'package:platy/features/manage_transactions/data/enums/Categories.dart';
import 'package:platy/features/manage_transactions/data/enums/TransactionStatus.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionCreateModel.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionModel.dart';
import 'package:platy/core/helpers/constants/style_constants.dart' as Theme;
import 'package:platy/core/widgets/Widgets.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionUpdateModel.dart';
import 'package:platy/features/manage_transactions/domain/usecases/DeleteTransaction.dart';
import 'package:platy/features/manage_transactions/domain/usecases/DeleteTransactions.dart';
import 'package:platy/features/manage_transactions/domain/usecases/UpdateTransaction.dart';
import 'package:platy/features/manage_transactions/domain/usecases/UpdateTransactions.dart';
import 'package:platy/injection_container.dart';
import 'package:progress_dialog/progress_dialog.dart';

class EditTransaction extends StatefulWidget {
  final Map<String, dynamic> args;

  EditTransaction({Key key, this.args}) : super(key: key);

  @override
  _EditTransactionState createState() => _EditTransactionState(this.args['callback'], this.args['transaction']);
}

class _EditTransactionState extends State<EditTransaction> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TransactionCreateModel createdTransaction = new TransactionCreateModel();

  TextEditingController valueController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController targetController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();

  final FocusNode myFocusNodeValue = FocusNode();
  final FocusNode myFocusNodeDescription = FocusNode();
  final FocusNode myFocusNodeTarget = FocusNode();
  final FocusNode myFocusNodeDate = FocusNode();
  final FocusNode myFocusNodeCategory = FocusNode();

  final List<Category> nCategories = Categories.LIST;

  bool _isNumberValid = true;
  bool _isDescriptionValid = true;
  bool _isDateValid = true;

  Function() _callback;
  TransactionModel _transaction;
  bool _transactionStatus;

  var dateFormatter = new MaskTextInputFormatter(mask: '##/##/####', filter: { "#": RegExp(r'[0-9]') });

  Map<String, Map<String, Color>> buttonCategories = {
    Categories.HABITACAO.name : {
      'backgroundColor': Theme.deselectedButtonBackgroundColor,
      'textColor': Theme.deselectedButtonTextColor
    },
    Categories.LAZER.name : {
      'backgroundColor': Theme.deselectedButtonBackgroundColor,
      'textColor': Theme.deselectedButtonTextColor
    },
    Categories.TRANSPORTE.name : {
      'backgroundColor': Theme.deselectedButtonBackgroundColor,
      'textColor': Theme.deselectedButtonTextColor
    },
    Categories.COMPRAS.name : {
      'backgroundColor': Theme.deselectedButtonBackgroundColor,
      'textColor': Theme.deselectedButtonTextColor
    },
    Categories.CONTAS.name : {
      'backgroundColor': Theme.deselectedButtonBackgroundColor,
      'textColor': Theme.deselectedButtonTextColor
    },
    Categories.ALIMENTACAO.name : {
      'backgroundColor': Theme.deselectedButtonBackgroundColor,
      'textColor': Theme.deselectedButtonTextColor
    },
    Categories.OUTROS.name : {
      'backgroundColor': Theme.deselectedButtonBackgroundColor,
      'textColor': Theme.deselectedButtonTextColor
    },
  };

  UpdateTransaction updateTransaction;
  UpdateTransactions updateTransactions;
  DeleteTransaction deleteTransaction;
  DeleteTransactions deleteTransactions;

  _EditTransactionState(Function callback, TransactionModel transaction) {
    _callback = callback;
    _transaction = transaction;

    updateTransaction = Injector.resolve<UpdateTransaction>();
    updateTransactions = Injector.resolve<UpdateTransactions>();
    deleteTransaction = Injector.resolve<DeleteTransaction>();
    deleteTransactions = Injector.resolve<DeleteTransactions>();

    valueController.text = _transaction.value.toString().replaceAll('.', ',');
    descriptionController.text = _transaction.description;
    targetController.text = _transaction.target != " " ? _transaction.target : null;
    dateController.text = dateToText(_transaction.date);
    _transactionStatus = _transaction.status;

    if(buttonCategories[transaction.category] != null) {
      buttonCategories[transaction.category]['backgroundColor'] = Theme.selectedButtonBackgroundColor;
      buttonCategories[transaction.category]['textColor'] = Theme.selectedButtonTextColor;
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: Padding(
            padding: EdgeInsets.only(left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
//                Text(_transaction.toString()),
                Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: BackButton(
                    color: Theme.inputSelectableIconColor,
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
                        hintText: 'Valor',
                        controller: valueController,
                        focusNode: myFocusNodeValue,
                        nextFocus: myFocusNodeDescription,
                        context: context
                    ), // CustomInput
                  ),
                ),
                Visibility(
                  visible: !_isNumberValid,
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
                Padding(
                  padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: Theme.formFieldsStyle,
                    height: 60.0,
                    child: customInput(
                        inputType: TextInputType.text,
                        hintText: 'Descrição',
                        controller: descriptionController,
                        focusNode: myFocusNodeDescription,
                        nextFocus: myFocusNodeTarget,
                        context: context
                    ), // CustomInput
                  ),
                ),
                Visibility(
                  visible: !_isDescriptionValid,
                  child:
                  Padding(
                      padding: EdgeInsets.only(bottom: 5.0, left: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Preencha a descrição',
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
                Padding(
                  padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: Theme.formFieldsStyle,
                    height: 60.0,
                    child: customInput(
                        inputType: TextInputType.text,
                        hintText: "Pago à / Recebido de",
                        controller: targetController,
                        focusNode: myFocusNodeTarget,
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
                        hintText: 'Data de vencimento (dd/mm/aa)',
                        controller: dateController,
                        focusNode: myFocusNodeDate,
                        context: context
                    ), // CustomInput
                  ),
                ),
                Visibility(
                  visible: !_isDateValid,
                  child:
                  Padding(
                      padding: EdgeInsets.only(bottom: 5.0, left: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Preencha uma data válida',
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
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 8, bottom: 12),
                          child: Text("Essa conta já foi paga?"),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Radio(
                                  value: TransactionStatus.PAGO,
                                  groupValue: _transactionStatus,
                                  onChanged: (bool value) {
                                    setState(() { _transactionStatus = value; });
                                  },
                                ),
                                Text('Sim'),
                              ]
                            ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Radio(
                                  value: TransactionStatus.PENDENTE,
                                  groupValue: _transactionStatus,
                                  onChanged: (bool value) {
                                    setState(() { _transactionStatus = value; });
                                  },
                                ),
                                Text('Não'),
                              ]
                            ),
                        ],
                      ),
                    ],
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24, bottom: 24),
                  child: Text(
                    'Categorias',
                    style: TextStyle(
                        fontSize: Theme.supportHeadersSize,
                        fontFamily: Theme.primaryFontFamily,
                        color: Theme.supportHeadersTextColor,
                        fontWeight: Theme.supportHeadersFontWeight
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4, bottom: 4),
                  child: _buildCategories()
                ),
                Container(
                  margin: EdgeInsets.only(top: 40.0),
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
                            submit();
                          },
                          child: Center(
                              child: customButton('Concluir')
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 32.0),
                      child: FlatButton(
                          onPressed: () {
                            removeTransaction();
                          },
                          child: Text(
                            "Remover transação",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Theme.linkLightBGTextColor,
                                fontSize: Theme.inputFontSize,
                                fontFamily: Theme.primaryFontFamily,
                                fontWeight: FontWeight.bold
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ),
      ),
    );
  }

  _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 4),
              child: InkWell(
                  child: Container(
                    height: 40,
                    width: 107,
                    decoration: BoxDecoration(
                      color: buttonCategories[Categories.HABITACAO.name]['backgroundColor'],
                      border: Border.all(color: Theme.selectedButtonBackgroundColor),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50.0),
                        onTap: () => {
                          changeCategorySelection(Categories.HABITACAO)
                        },
                        child: Center(
                          child: Text(
                            Categories.HABITACAO.name,
                            style: TextStyle(
                                color: buttonCategories[Categories.HABITACAO.name]['textColor'],
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
            Padding(
              padding: EdgeInsets.only(left: 4),
              child: InkWell(
                  child: Container(
                    height: 40,
                    width: 112,
                    decoration: BoxDecoration(
                      color: buttonCategories[Categories.LAZER.name]['backgroundColor'],
                      border: Border.all(color: Theme.selectedButtonBackgroundColor),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50.0),
                        onTap: () => {
                          changeCategorySelection(Categories.LAZER)
                        },
                        child: Center(
                          child: Text(
                            Categories.LAZER.name,
                            style: TextStyle(
                                color: buttonCategories[Categories.LAZER.name]['textColor'],
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
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 4, top: 16),
                child: InkWell(
                  child: Container(
                    height: 40,
                    width: 126,
                    decoration: BoxDecoration(
                      color: buttonCategories[Categories.TRANSPORTE.name]['backgroundColor'],
                      border: Border.all(color: Theme.selectedButtonBackgroundColor),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50.0),
                        onTap: () => {
                          changeCategorySelection(Categories.TRANSPORTE)
                        },
                        child: Center(
                          child: Text(
                            Categories.TRANSPORTE.name,
                            style: TextStyle(
                                color: buttonCategories[Categories.TRANSPORTE.name]['textColor'],
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
            Padding(
                padding: EdgeInsets.only(left: 4, top: 16),
                child: InkWell(
                  child: Container(
                    height: 40,
                    width: 128,
                    decoration: BoxDecoration(
                      color: buttonCategories[Categories.COMPRAS.name]['backgroundColor'],
                      border: Border.all(color: Theme.selectedButtonBackgroundColor),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50.0),
                        onTap: () => {
                          changeCategorySelection(Categories.COMPRAS)
                        },
                        child: Center(
                          child: Text(
                            Categories.COMPRAS.name,
                            style: TextStyle(
                                color: buttonCategories[Categories.COMPRAS.name]['textColor'],
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 4, top: 16),
                child: InkWell(
                  child: Container(
                    height: 40,
                    width: 128,
                    decoration: BoxDecoration(
                      color: buttonCategories[Categories.CONTAS.name]['backgroundColor'],
                      border: Border.all(color: Theme.selectedButtonBackgroundColor),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50.0),
                        onTap: () => {
                          changeCategorySelection(Categories.CONTAS)
                        },
                        child: Center(
                          child: Text(
                            Categories.CONTAS.name,
                            style: TextStyle(
                                color: buttonCategories[Categories.CONTAS.name]['textColor'],
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
            Padding(
                padding: EdgeInsets.only(left: 4, top: 16),
                child: InkWell(
                  child: Container(
                    height: 40,
                    width: 128,
                    decoration: BoxDecoration(
                      color: buttonCategories[Categories.ALIMENTACAO.name]['backgroundColor'],
                      border: Border.all(color: Theme.selectedButtonBackgroundColor),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50.0),
                        onTap: () => {
                          changeCategorySelection(Categories.ALIMENTACAO)
                        },
                        child: Center(
                          child: Text(
                            Categories.ALIMENTACAO.name,
                            style: TextStyle(
                                color: buttonCategories[Categories.ALIMENTACAO.name]['textColor'],
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 4, top: 16),
                child: InkWell(
                  child: Container(
                    height: 40,
                    width: 128,
                    decoration: BoxDecoration(
                      color: buttonCategories[Categories.OUTROS.name]['backgroundColor'],
                      border: Border.all(color: Theme.selectedButtonBackgroundColor),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50.0),
                        onTap: () => {
                          changeCategorySelection(Categories.OUTROS)
                        },
                        child: Center(
                          child: Text(
                            Categories.OUTROS.name,
                            style: TextStyle(
                                color: buttonCategories[Categories.OUTROS.name]['textColor'],
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
        )
      ],
    );
  }

  changeCategorySelection(Category category) {
    Map<String, Map<String, Color>> newButtons = {
      Categories.HABITACAO.name : {
        'backgroundColor': Theme.deselectedButtonBackgroundColor,
        'textColor': Theme.deselectedButtonTextColor
      },
      Categories.LAZER.name : {
        'backgroundColor': Theme.deselectedButtonBackgroundColor,
        'textColor': Theme.deselectedButtonTextColor
      },
      Categories.TRANSPORTE.name : {
        'backgroundColor': Theme.deselectedButtonBackgroundColor,
        'textColor': Theme.deselectedButtonTextColor
      },
      Categories.COMPRAS.name : {
        'backgroundColor': Theme.deselectedButtonBackgroundColor,
        'textColor': Theme.deselectedButtonTextColor
      },
      Categories.CONTAS.name : {
        'backgroundColor': Theme.deselectedButtonBackgroundColor,
        'textColor': Theme.deselectedButtonTextColor
      },
      Categories.ALIMENTACAO.name : {
        'backgroundColor': Theme.deselectedButtonBackgroundColor,
        'textColor': Theme.deselectedButtonTextColor
      },
      Categories.OUTROS.name : {
        'backgroundColor': Theme.deselectedButtonBackgroundColor,
        'textColor': Theme.deselectedButtonTextColor
      },
    };

    Categories.LIST.forEach((c) {
        newButtons[c.name]['backgroundColor'] = Theme.deselectedButtonBackgroundColor;
        newButtons[c.name]['textColor'] = Theme.deselectedButtonTextColor;
    });

    newButtons[category.name]['backgroundColor'] = Theme.selectedButtonBackgroundColor;
    newButtons[category.name]['textColor'] = Theme.selectedButtonTextColor;

    setState(() {
      this._transaction.category = category.name;
      this.buttonCategories = newButtons;
    });
  }

  dateToText(DateTime date) {
    var dateString = date.day.toString().padLeft(2, '0') + '/' + date.month.toString().padLeft(2, '0') + '/' + date.year.toString();
    return dateString;
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
      _isNumberValid = valid;
    });
  }

  parseDate(String dateMask, String dateController) {
    var date = dateMask == "" ? dateController : dateMask;

    return new DateTime(int.parse(date.substring(6, 10)), int.parse(date.substring(3, 5)), int.parse(date.substring(0, 2)));
  }

  validateDescription(String description) {
    bool valid;

    if(description.isNotEmpty) {
      valid = true;
    } else {
      valid = false;
    }

    setState(() {
      _isDescriptionValid = valid;
    });
  }

  validateDate(String dateMask, String dateController) {
    var date = dateMask == "" ? dateController : dateMask;

    bool valid;

    if(brDateRegex.hasMatch(date)) {
      valid = true;
    } else {
      valid = false;
    }

    setState(() {
      _isDateValid = valid;
    });
  }

  void removeTransaction() async {
    final ProgressDialog pr = ProgressDialog(context);
    pr.style(message: "Removendo transação");

    await pr.show();

    if(_transaction.quotas != "unique") {
      switch (await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: Text(
                'Esta transação é recorrente. Gostaria de remover as próximas recorrências caso existam?',
                style: TextStyle(
                  color: Theme.dirtyInputTextColor,
                  fontSize: Theme.behaviorDescriptionFontSize,
                  fontWeight: Theme.modalFontWeight,
                ),
              ),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SimpleDialogOption(
                      onPressed: () { Navigator.pop(context, false); },
                      child: const Text('Não'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: SimpleDialogOption(
                        onPressed: () { Navigator.pop(context, true); },
                        child: const Text('Sim'),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
      )) {
        case true:
          var params = new List<String>();
          params.add(_transaction.id);
          params.add(_transaction.quotas);

          var response = await deleteTransactions(params);
          response.fold(
                  (error) async {
                await pr.hide();
                showRemoveErrorDialog(context);
              },
                  (retrieved) async {
                await pr.hide();
                showRemoveSuccessDialog(context);
              }
          );
          break;
        case false:
          var response = await deleteTransaction(_transaction.id);
          response.fold(
                  (error) async {
                await pr.hide();
                showRemoveErrorDialog(context);
              },
                  (retrieved) async {
                await pr.hide();
                showRemoveSuccessDialog(context);
              }
          );
          break;
      }
    } else {
      var response = await deleteTransaction(_transaction.id);
      response.fold(
              (error) async {
            await pr.hide();
            showRemoveErrorDialog(context);
          },
              (retrieved) async {
            await pr.hide();
            showRemoveSuccessDialog(context);
          }
      );
    }
  }

  submit() async {
    validateDescription(descriptionController.text);
    validateDate(dateFormatter.getMaskedText(), dateController.text);
    numberValidation(valueController.text);

    if(_isDescriptionValid && _isDateValid && _isNumberValid) {
      var date = parseDate(dateFormatter.getMaskedText(), dateController.text);
      var target = targetController.text.isEmpty ? ' ' : targetController.text;

      var value = brNumberRegex.hasMatch(valueController.text) ? valueController.text.split(',').join('.') : valueController.text;

      _transaction.date = date;
      _transaction.target = target;
      _transaction.value = double.parse(value);
      _transaction.description = descriptionController.text;
      _transaction.status = _transactionStatus;

      final ProgressDialog pr = ProgressDialog(context);
      pr.style(message: "Atualizando transação");

      await pr.show();

      var updatedTransaction = new TransactionUpdateModel(
          id: _transaction.id,
          account: _transaction.account,
          category: _transaction.category,
          date: _transaction.date,
          description: _transaction.description,
          quotas: _transaction.quotas,
          status: _transaction.status,
          target: _transaction.target,
          type: _transaction.type,
          value: _transaction.value,
      );

      if(updatedTransaction.quotas != "unique") {
        switch (await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: Text(
                      'Esta transação é recorrente. Gostaria de atualizar as próximas recorrências caso existam?',
                      style: TextStyle(
                        color: Theme.dirtyInputTextColor,
                        fontSize: Theme.behaviorDescriptionFontSize,
                        fontWeight: Theme.modalFontWeight,
                  ),
                ),
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SimpleDialogOption(
                        onPressed: () { Navigator.pop(context, false); },
                        child: const Text('Não'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: SimpleDialogOption(
                          onPressed: () { Navigator.pop(context, true); },
                          child: const Text('Sim'),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
        )) {
          case true:
            var response = await updateTransactions(updatedTransaction);
            response.fold(
                    (error) async {
                  await pr.hide();
                  showEditErrorDialog(context);
                },
                    (retrieved) async {
                  await pr.hide();
                  showEditSuccessDialog(context);
                }
            );
            break;
          case false:
            var response = await updateTransaction(updatedTransaction);
            response.fold(
                    (error) async {
                  await pr.hide();
                  showEditErrorDialog(context);
                },
                    (retrieved) async {
                  await pr.hide();
                  showEditSuccessDialog(context);
                }
            );
            break;
        }
      } else {
        var response = await updateTransaction(updatedTransaction);
        response.fold(
                (error) async {
              await pr.hide();
              showEditErrorDialog(context);
            },
                (retrieved) async {
              await pr.hide();
              showEditSuccessDialog(context);
            }
        );
      }
    }
  }

  void showEditSuccessDialog(BuildContext context) {
    Dialog dialog = CustomDialog(
        assetPath: 'assets/images/animations/transaction_ok.json',
        width: 106,
        height: 76,
        message: 'Transação atualizada\ncom sucesso',
        behaviour: () {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context).pop();
        });

    showDialog(barrierDismissible: false, context: context, builder: (BuildContext context) => dialog);
  }

  void showEditErrorDialog(BuildContext context) {
    Dialog dialog = CustomDialog(
        assetPath: 'assets/images/animations/transaction_error.json',
        width: 76,
        height: 76,
        message: 'Ocorreu um erro ao atualizar a transação',
        behaviour: () {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context).pop();
        });

    showDialog(barrierDismissible: false, context: context, builder: (BuildContext context) => dialog);
  }

  void showRemoveSuccessDialog(BuildContext context) {
    Dialog dialog = CustomDialog(
        assetPath: 'assets/images/animations/transaction_ok.json',
        width: 106,
        height: 76,
        message: 'Transação removida\ncom sucesso',
        behaviour: () {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context).pop();
        });

    showDialog(barrierDismissible: false, context: context, builder: (BuildContext context) => dialog);
  }

  void showRemoveErrorDialog(BuildContext context) {
    Dialog dialog = CustomDialog(
        assetPath: 'assets/images/animations/transaction_error.json',
        width: 76,
        height: 76,
        message: 'Ocorreu um erro ao remover a transação',
        behaviour: () {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context).pop();
        });

    showDialog(barrierDismissible: false, context: context, builder: (BuildContext context) => dialog);
  }
}