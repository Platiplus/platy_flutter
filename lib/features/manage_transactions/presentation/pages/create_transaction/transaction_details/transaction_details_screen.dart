import 'package:flutter/material.dart';
import 'package:platy/core/helpers/constants/utilities_constants.dart';
import 'package:platy/core/widgets/Widgets.dart';
import 'package:platy/features/manage_transactions/data/enums/Categories.dart';
import 'package:platy/features/manage_transactions/data/models/TransactionCreateModel.dart';
import 'package:platy/core/helpers/constants/style_constants.dart' as Theme;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreateTransactionDetails extends StatefulWidget {
  final Function(String, String, DateTime, String) callback;
  final TransactionCreateModel transaction;
  CreateTransactionDetails({ this.callback, this.transaction });

  @override
  _CreateTransactionDetailsState createState() => _CreateTransactionDetailsState();
}

class _CreateTransactionDetailsState extends State<CreateTransactionDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FocusNode myFocusNodeDescription = FocusNode();
  final FocusNode myFocusNodeTarget = FocusNode();
  final FocusNode myFocusNodeDate = FocusNode();
  final List<Category> nCategories = Categories.LIST;
  Category _selectedCategory;

  TextEditingController descriptionController = new TextEditingController();
  TextEditingController targetController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();

  bool _isCategoryValid = true;
  bool _isDescriptionValid = true;
  bool _isDateValid = true;

  var dateFormatter = new MaskTextInputFormatter(mask: '##/##/####', filter: { "#": RegExp(r'[0-9]') });

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
                  alignment: Alignment.centerRight,
                  decoration: Theme.formFieldsStyle,
                  height: 60.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: DropdownButton<Category>(
                      hint: Text('Categoria'),
                      underline: SizedBox(),
                      isExpanded: true,
                      style: TextStyle(
                        color: Theme.dirtyInputTextColor,
                        fontSize: Theme.inputFontSize,
                      ),
                      icon: Icon(CSIcons.arrow_down, color: Theme.inputSelectableIconColor, size: Theme.inputIconSize),
                      value: _selectedCategory,
                      items: _buildDropdown(),
                      onChanged: onChangeDropdownItem,
                    ),
                  )
              ),
            ),
            Visibility(
              visible: !_isCategoryValid,
              child:
              Padding(
                  padding: EdgeInsets.only(bottom: 5.0, left: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Selecione uma categoria',
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
          ],
        ),
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

  submit() {
    validateDescription(descriptionController.text);
    validateDate(dateFormatter.getMaskedText());
    validateCategory(_selectedCategory);
    if(_isDescriptionValid && _isDateValid && _isCategoryValid) {
      var date = parseDate();
      var target = targetController.text.isEmpty ? ' ' : targetController.text;
      widget.callback(descriptionController.text, target, date, _selectedCategory.name);
    }
  }

  _buildDropdown() {
    var list = new List<DropdownMenuItem<Category>>();
      for (var item in nCategories) {
        list.add(new DropdownMenuItem<Category>(
          value: item,
          child: new Text(item.name),
        ));
      }
      return list;
  }

  onChangeDropdownItem(Category item) {
    setState(() {
      _selectedCategory = item;
    });
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

  validateDate(String date) {
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

  validateCategory(Category category) {
    bool valid;

    if(category != null) {
      valid = true;
    } else {
      valid = false;
    }

    setState(() {
      _isCategoryValid = valid;
    });
  }

  parseDate() {
    var date = dateFormatter.getMaskedText();
    return new DateTime(int.parse(date.substring(6, 10)), int.parse(date.substring(3, 5)), int.parse(date.substring(0, 2)));
  }

}