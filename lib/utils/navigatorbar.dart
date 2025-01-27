import 'package:flutter/material.dart';

import 'package:app_passion_apiculture/screens/basic_screen.dart';
import 'package:app_passion_apiculture/screens/home_screen.dart';
import 'package:app_passion_apiculture/screens/signup_screen.dart';


class MainNavigator extends StatefulWidget {
  @override
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;

  List<Widget> _sreens = [
    HomeScreen(),
    BasicTestScreen(),
    SignupScreen(),
  ];

  @override 
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
        },
        indicatorColor: Colors.amber,
        destinations: <Widget>[
          const NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: const Badge(child: Icon(Icons.notifications_sharp)),
            label: 'Notifications',
          ),
          const NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.messenger_sharp),
            ),
            label: 'Messages',
          ),
        ],
      ),
      )
    );
  }
}