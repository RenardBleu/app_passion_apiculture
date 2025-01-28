import 'package:app_passion_apiculture/providers/user_provider.dart';
import 'package:app_passion_apiculture/screens/user_screen.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:app_passion_apiculture/screens/basic_screen.dart';
import 'package:app_passion_apiculture/screens/accueil_screen.dart';
import 'package:app_passion_apiculture/screens/signup_screen.dart';
import 'package:app_passion_apiculture/screens/user_screen.dart';

/*class Home2Screen extends StatelessWidget {
  const Home2Screen({Key? key}) : super(key: key);

  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil")
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.email),
            ElevatedButton(
              onPressed: () => signOutUser(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Se déconnecter'),
            ),
          ],
        )
      ),
    );
  }
}*/


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

@override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context).user;

    final List<List> _screens = [
      [AccueilScreen(user), "Accueil"],
      [BasicTestScreen(user), "test1"],
      [SignupScreen(), "test2"],
    /*AccueilScreen(user),
    BasicTestScreen(user),
    SignupScreen(),*/
  ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_currentIndex][1]),
         actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Show profil',
            onPressed: () {
              Navigator.push(
              context,
                MaterialPageRoute(builder: (context) => UserScreen(user)),
              );
            }
          )
        ]
      ),
      body: _screens[_currentIndex][0], // Change le contenu ici
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Index sélectionné
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Met à jour l'index sélectionné
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}