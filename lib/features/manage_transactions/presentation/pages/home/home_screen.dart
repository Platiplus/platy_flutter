import 'package:flutter/material.dart';
import 'package:platy/features/manage_transactions/presentation/pages/control/control_screen.dart';
import 'package:platy/features/manage_transactions/presentation/pages/profile/profile_screen.dart';
import 'package:platy/core/widgets/Widgets.dart';
import 'package:platy/core/helpers/constants/style_constants.dart' as Theme;

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
    Profile()
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
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