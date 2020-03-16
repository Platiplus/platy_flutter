import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:platy/Utils/style_constants.dart' as Theme;
import 'package:platy/Widgets/CustomWidgets.dart';
import 'package:platy/Utils/bubble_indication_painter.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {

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
  bool _authenticationFailed = false;

  bool _signUpNameIsValid = true;
  bool _signUpEmailIsValid  = true;
  bool _signUpPasswordIsValid = true;

  PageController _pageController;

  Color leftMenuTextColor = Theme.primaryHeaderColor;
  Color rightMenuTextColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    return new Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height >= 775.0
                    ? MediaQuery.of(context).size.height
                    : 775.0,
                decoration: new BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/backgrounds/initial-bg-01.png'),
                    alignment: Alignment.bottomCenter
                  ),
                  color: Color(0xFF223254)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 75.0, bottom: 30),
                      child: InkWell(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Color(0x50FFFFFF),
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                        ),
                      )
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

                          FocusScope.of(context).requestFocus(new FocusNode());
                          if (i == 0) {
                            setState(() {
                              rightMenuTextColor = Colors.white;
                              leftMenuTextColor = Theme.primaryHeaderColor;
                            });
                          } else if (i == 1) {
                            setState(() {
                              rightMenuTextColor = Theme.primaryHeaderColor;
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

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
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

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
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
                      fontSize: Theme.header2FontSize,
                      fontFamily: Theme.primaryFontFamily,
                      fontWeight: FontWeight.bold
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
                      fontSize: Theme.header2FontSize,
                      fontFamily: Theme.primaryFontFamily,
                      fontWeight: FontWeight.bold
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
                  height: 223.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 30.0, bottom: 8.0, left: 25.0, right: 25.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          decoration: Theme.formFieldsStyle,
                          height: 60.0,
                          child: CustomInput(
                              inputType: TextInputType.emailAddress,
                              hintText: 'Email',
                              prefixIcon: Icon(FontAwesomeIcons.envelope, color: Theme.inputIconColor, size: Theme.inputIconSize),
                              controller: loginEmailController,
                              focusNode: myFocusNodeEmailLogin,
                              nextFocus: myFocusNodePasswordLogin,
                              context: context
                          ), //CustomInput
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 8.0, bottom: 5.0, left: 25.0, right: 25.0),
                        child:
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: Theme.formFieldsStyle,
                          height: 60.0,
                          child: CustomInput(
                              obscure: _obscureTextLogin,
                              inputType: TextInputType.visiblePassword,
                              hintText: 'Senha',
                              prefixIcon: Icon(FontAwesomeIcons.lock, color: Theme.inputIconColor, size: Theme.inputIconSize),
                              suffixIcon: IconButton(
                                  onPressed: _toggleLogin,
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  icon: Icon(_obscureTextLogin == true ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash, size: Theme.inputIconSize, color: Theme.linkTextColor),
                                  padding: EdgeInsets.only(right: 14.0),
                                  color: Color(0xFF606A7B),
                              ),
                              controller: loginPasswordController,
                              focusNode: myFocusNodePasswordLogin,
                          ), //CustomInput
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 197.0),
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
                        onTap: () => {
                        },
                        child: Center(
                          child: CustomButton('Entrar')
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
                  Navigator.of(context).pushNamed('forgot');
                },
                child: Text(
                  "Esqueceu a senha?",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: Theme.header2FontSize,
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
                  height: 300.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 30.0, bottom: 8.0, left: 25.0, right: 25.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          decoration: Theme.formFieldsStyle,
                          height: 60.0,
                          child: CustomInput(
                              hintText: 'Nome',
                              prefixIcon: Icon(FontAwesomeIcons.user, color: Theme.inputIconColor, size: Theme.inputIconSize),
                              controller: signupNameController,
                              focusNode: myFocusNodeName,
                              nextFocus: myFocusNodeEmail,
                              context: context
                          ) // CustomInput
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 25.0, right: 25.0),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            decoration: Theme.formFieldsStyle,
                            height: 60.0,
                            child: CustomInput(
                                inputType: TextInputType.emailAddress,
                                hintText: 'Email',
                                prefixIcon: Icon(FontAwesomeIcons.envelope, color: Theme.inputIconColor, size: Theme.inputIconSize),
                                controller: signupEmailController,
                                focusNode: myFocusNodeEmail,
                                nextFocus: myFocusNodePassword,
                                context: context
                            ) // CustomInput
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 8.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          decoration: Theme.formFieldsStyle,
                          height: 60.0,
                          child: CustomInput(
                              obscure: _obscureTextSignup,
                              inputType: TextInputType.visiblePassword,
                              hintText: 'Senha',
                              prefixIcon: Icon(FontAwesomeIcons.lock, color: Theme.inputIconColor, size: Theme.inputIconSize),
                              suffixIcon: IconButton(
                                onPressed: _toggleSignup,
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                icon: Icon(_obscureTextSignup == true ? FontAwesomeIcons.eye: FontAwesomeIcons.eyeSlash, size: Theme.inputIconSize, color: Theme.linkTextColor),
                                padding: EdgeInsets.only(right: 14.0),
                                color: Color(0xFF606A7B),
                              ),
                              controller: signupPasswordController,
                              focusNode: myFocusNodePassword
                          ) //CustomInput
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 273.0),
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
                        onTap: () => {
                          showInSnackBar("SignUp button pressed")
                        },
                        child: Center(
                            child: CustomButton('Cadastrar')
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

  void showInSnackBar(String value) {
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: Theme.header2FontSize,
            fontFamily: Theme.primaryFontFamily),
      ),
      backgroundColor: Theme.errorFeedbackColor,
      duration: Duration(seconds: 3),
    ));
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
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

  void validateLogin(){
    RegExp emailReg = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
        caseSensitive: false,
        multiLine: false );

    if(loginEmailController.text.isEmpty || !emailReg.hasMatch(loginEmailController.text)){
      _loginEmailIsValid = false;
    }
  }

}
