// FLUTTER DEPENDENCIES
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// EXTERNAL DEPENDENCIES
import 'package:platy/core/helpers/constants/endpoint_constants.dart';
import 'package:platy/core/helpers/constants/utilities_constants.dart';
import 'package:platy/core/helpers/constants/style_constants.dart' as Theme;
import 'package:platy/features/manage_transactions/presentation/widgets/Widgets.dart';
import 'package:platy/core/helpers/utils/Utils.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {

  //VARIABLES
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();
  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();
  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;

  bool _loginEmailIsValid = true;
  bool _loginPasswordIsValid = true;

  bool _signUpNameIsValid = true;
  bool _signUpEmailIsValid  = true;
  bool _signUpPasswordIsValid = true;

  PageController _pageController;

  Color leftMenuTextColor = Theme.moneyBalanceTextColor;
  Color rightMenuTextColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    return new Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return true;
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 775.0
                ? MediaQuery.of(context).size.height
                : 775.0,
            decoration: new BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/backgrounds/background.png'),
                    alignment: Alignment.bottomCenter
                ),
                color: Theme.appBackgroundColor
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 75.0, bottom: 30),
                    child: Container(
                      width: 250,
                      height: 190,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/illustrations/platy-login.png'),
                            alignment: Alignment.bottomCenter
                        ),
                      ),
                    ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: _buildMenuBar(context),
                ),
                Expanded(
                  flex: 2,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (i) {
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }

                      if (i == 0) {
                        setState(() {
                          rightMenuTextColor = Colors.white;
                          leftMenuTextColor = Theme.moneyBalanceTextColor;
                        });
                      } else if (i == 1) {
                        setState(() {
                          rightMenuTextColor = Theme.moneyBalanceTextColor;
                          leftMenuTextColor = Colors.white;
                        });
                      }
                    },
                    children: <Widget>[
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignIn(context),
                      ),
                      new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignUp(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //STATE MANAGEMENT
  @override
  void dispose() {
    myFocusNodeEmailLogin.dispose();
    myFocusNodePasswordLogin.dispose();
    myFocusNodeName.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodePassword.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  //BUILD WIDGETS
  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: Theme.loginMenuBackgroundColorUnselected,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainterTwoItems(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: leftMenuTextColor,
                      fontSize: Theme.sliderMenuFontSize,
                      fontFamily: Theme.primaryFontFamily,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "Cadastro",
                  style: TextStyle(
                      color: rightMenuTextColor,
                      fontSize: Theme.sliderMenuFontSize,
                      fontFamily: Theme.primaryFontFamily,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 220.0 + (!_loginEmailIsValid ? 15.0 : 0) + (!_loginPasswordIsValid ? 15.0 : 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 30.0, bottom: 5.0, left: 25.0, right: 25.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          decoration: Theme.formFieldsStyle,
                          height: 60.0,
                          child: customInput(
                              inputType: TextInputType.emailAddress,
                              hintText: 'E-mail',
                              prefixIcon: Icon(CSIcons.mail, color: Theme.inputIconColor, size: Theme.inputIconSize),
                              controller: loginEmailController,
                              focusNode: myFocusNodeEmailLogin,
                              nextFocus: myFocusNodePasswordLogin,
                              context: context
                          ), //CustomInput
                        ),
                      ),
                      Visibility(
                        visible: !_loginEmailIsValid,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 5.0, left: 52.0),
                            child: Text(
                              (loginEmailController.text.isEmpty ? 'Preencha seu e-mail' : 'Verifique seu e-mail'),
                            style: TextStyle(
                                fontFamily: Theme.primaryFontFamily,
                                fontSize: Theme.errorFeedbackFontSize,
                                color: Theme.errorFeedbackColor
                            ),
                          ),
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 8.0, bottom: 5.0, left: 25.0, right: 25.0),
                        child:
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: Theme.formFieldsStyle,
                          height: 60.0,
                          child: customInput(
                              obscure: _obscureTextLogin,
                              inputType: TextInputType.visiblePassword,
                              hintText: 'Senha',
                              prefixIcon: Icon(CSIcons.lock, color: Theme.inputIconColor, size: Theme.inputIconSize),
                              suffixIcon: IconButton(
                                  onPressed: _toggleLogin,
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  icon: Icon(_obscureTextLogin == true ? CSIcons.view : CSIcons.view_off, size: Theme.inputIconSize, color: Theme.inputSelectableIconColor),
                                  color: Color(0xFF606A7B),
                              ),
                              controller: loginPasswordController,
                              focusNode: myFocusNodePasswordLogin,
                          ), //CustomInput
                        ),
                      ),
                      Visibility(
                        visible: !_loginPasswordIsValid,
                        child:
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.0, left: 52.0),
                          child: Text(
                            'Preencha sua senha',
                            style: TextStyle(
                                fontFamily: Theme.primaryFontFamily,
                                fontSize: Theme.errorFeedbackFontSize,
                                color: Theme.errorFeedbackColor
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 192.0 + (!_loginEmailIsValid ? 15.0 : 0) + (!_loginPasswordIsValid ? 15.0 : 0)),
                width: 240,
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
                          if(validateLogin()){
                            signIn(loginEmailController.text, loginPasswordController.text);
                          }
                        },
                        child: Center(
                          child: customButton('Entrar')
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('home');
                },
                child: Text(
                  "Esqueceu a senha?",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: Theme.linkFontSize,
                      fontFamily: Theme.primaryFontFamily,
                      fontWeight: FontWeight.bold
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 300.0 + (!_signUpNameIsValid ? 15.0 : 0) + (!_signUpEmailIsValid ? 15.0 : 0) + (!_signUpPasswordIsValid ? 15.0 : 0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 30.0, bottom: 5.0, left: 25.0, right: 25.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          decoration: Theme.formFieldsStyle,
                          height: 60.0,
                          child: customInput(
                              hintText: 'Nome',
                              prefixIcon: Icon(CSIcons.user, color: Theme.inputIconColor, size: Theme.inputIconSize),
                              controller: signupNameController,
                              focusNode: myFocusNodeName,
                              nextFocus: myFocusNodeEmail,
                              context: context
                          ), // CustomInput
                        ),
                      ),
                      Visibility(
                        visible: !_signUpNameIsValid,
                        child:
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.0, right: 65.0),
                          child: Text(
                            'Preencha o seu nome',
                            style: TextStyle(
                                fontFamily: Theme.primaryFontFamily,
                                fontSize: Theme.errorFeedbackFontSize,
                                color: Theme.errorFeedbackColor
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 8.0, bottom: 5.0, left: 25.0, right: 25.0),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            decoration: Theme.formFieldsStyle,
                            height: 60.0,
                            child: customInput(
                                inputType: TextInputType.emailAddress,
                                hintText: 'Email',
                                prefixIcon: Icon(CSIcons.mail, color: Theme.inputIconColor, size: Theme.inputIconSize),
                                controller: signupEmailController,
                                focusNode: myFocusNodeEmail,
                                nextFocus: myFocusNodePassword,
                                context: context
                            ) // CustomInput
                        ),
                      ),
                      Visibility(
                        visible: !_signUpEmailIsValid,
                        child:
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.0, right: 65.0),
                          child: Text(
                            'Preencha o seu email',
                            style: TextStyle(
                                fontFamily: Theme.primaryFontFamily,
                                fontSize: Theme.errorFeedbackFontSize,
                                color: Theme.errorFeedbackColor
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 8.0, bottom: 5.0, left: 25.0, right: 25.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          decoration: Theme.formFieldsStyle,
                          height: 60.0,
                          child: customInput(
                              obscure: _obscureTextSignup,
                              inputType: TextInputType.visiblePassword,
                              hintText: 'Senha',
                              prefixIcon: Icon(CSIcons.lock, color: Theme.inputIconColor, size: Theme.inputIconSize),
                              suffixIcon: IconButton(
                                onPressed: _toggleSignup,
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                icon: Icon(_obscureTextSignup == true ? CSIcons.view: CSIcons.view_off, size: Theme.inputIconSize, color: Theme.inputSelectableIconColor),
                                color: Color(0xFF606A7B),
                              ),
                              controller: signupPasswordController,
                              focusNode: myFocusNodePassword
                          ) //CustomInput
                        ),
                      ),
                      Visibility(
                        visible: !_signUpPasswordIsValid,
                        child:
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.0, right: 65.0),
                          child: Text(
                            'Preencha a sua senha',
                            style: TextStyle(
                                fontFamily: Theme.primaryFontFamily,
                                fontSize: Theme.errorFeedbackFontSize,
                                color: Theme.errorFeedbackColor
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 273.0 + (!_signUpNameIsValid ? 15.0 : 0) + (!_signUpEmailIsValid ? 15.0 : 0) + (!_signUpPasswordIsValid ? 15.0 : 0)),
                width: 240,
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

                          if(validateSignup()){
                            signUp(signupNameController.text, signupEmailController.text, signupPasswordController.text);
                          }
                        },
                        child: Center(
                            child: customButton('Cadastrar')
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // FUNCTIONS
  void showInSnackBar(String value) {
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: Theme.snackFontSize,
            fontFamily: Theme.primaryFontFamily),
      ),
      backgroundColor: Theme.errorFeedbackColor,
      duration: Duration(seconds: 3),
    ));
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 800), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 800), curve: Curves.decelerate);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  bool validateLogin(){
    var email = true;
    var password = true;

    if(loginEmailController.text.isEmpty || !emailRegex.hasMatch(loginEmailController.text)){
      email = false;
    }

    if(loginPasswordController.text.isEmpty) {
      password = false;
    }

    setState(() {
      _loginEmailIsValid = email;
      _loginPasswordIsValid = password;
    });

    if(email && password){
      return true;
    }

    return false;
  }

  bool validateSignup(){
    var name = true;
    var email = true;
    var password = true;

    if(signupNameController.text.isEmpty){
      name = false;
    }

    if(signupEmailController.text.isEmpty || !emailRegex.hasMatch(signupEmailController.text)){
      email = false;
    }

    if(signupPasswordController.text.isEmpty) {
      password = false;
    }

    setState(() {
      _signUpNameIsValid = name;
      _signUpEmailIsValid = email;
      _signUpPasswordIsValid = password;
    });

    if(name && email && password){
      return true;
    }

    return false;

  }

  void signIn(String email, String password) async {
    Map data = {
      'email': email,
      'password': password
    };
    
    var tokens;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http.post(scheme + '://' + apiBaseUrl + '/' + authenticationUrl, body: data);

    if(response.statusCode == 201) {
      tokens = json.decode(response.body);
      setState(() {
        sharedPreferences.setString('accessToken', tokens['token']);
        sharedPreferences.setString('refreshToken', tokens['refreshToken']);
        Navigator.of(context).pushNamed('home');
      });
    } else {
      showInSnackBar("USUÁRIO E/OU SENHA INVÁLIDOS");
    }
  }

  void signUp(String username, String email, String password) async {
    Map data = {
      'username': username,
      'email': email,
      'password': password,
      'initialBalance': 0.0
    };

    var response = await http.post(scheme + '://' + authApiUrl + '/' + signupUrl, body: json.encode(data), headers: requestHeaders);

    if(response.statusCode == 201) {
        showInSnackBar('USUÁRIO CRIADO COM SUCESSO!');
    } else {
      showInSnackBar("ERRO AO CRIAR USUÁRIO");
    }
  }
}
