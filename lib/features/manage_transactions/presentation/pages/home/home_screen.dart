import 'package:flutter/material.dart';
import 'package:platy/features/manage_transactions/presentation/pages/control/control_screen.dart';
import 'package:platy/features/manage_transactions/presentation/pages/profile/profile_screen.dart';
import 'package:platy/features/manage_transactions/presentation/pages/wallet/wallet_screen.dart';
import 'package:platy/features/manage_transactions/presentation/widgets/Widgets.dart';
import 'package:platy/core/helpers/styles/Styles.dart' as Theme;

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _currentIndex = 0;

  final List<Widget> _children = [
    Control(),
    Wallet(),
    Profile()
  ];

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.appBackgroundColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0x50FFFFFF),
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(CSIcons.fast_money),
            title: new Text('Controle'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(CSIcons.economy),
            title: new Text('Carteira'),
          ),
          BottomNavigationBarItem(
              icon: Icon(CSIcons.user),
              title: Text('Perfil')
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}