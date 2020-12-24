import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:platy/core/helpers/constants/style_constants.dart' as Theme;
import 'package:platy/core/widgets/CustomButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 173,
                height: 192,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/illustrations/platy-notransactions.png'),
                        alignment: Alignment.bottomCenter
                    ),
                    color: Colors.white
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Text(
                  'Clique aqui para deslogar da aplicação.\n\nPor segurança, iremos fechar a aplicação.\nReinicie para continuar.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.supportTextColor,
                    fontSize: Theme.supportFontSize,
                    fontFamily: Theme.primaryFontFamily,
                  ),
                ),
              ),
              Container(
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
                        onTap: () async {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          clearDataAndLogout();
                        },
                        child: Center(
                            child: customButton('Sair')
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ]
    );
  }

  clearDataAndLogout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('refreshToken');
    sharedPreferences.remove('userId');
    sharedPreferences.remove('accountId');

    SystemChannels.platform.invokeMethod('SystemNavigator.pop', true);
  }
}