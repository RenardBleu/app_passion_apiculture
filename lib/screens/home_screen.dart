import 'package:app_passion_apiculture/providers/user_provider.dart';
import 'package:app_passion_apiculture/providers/product_provider.dart';
import 'package:app_passion_apiculture/services/product_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:app_passion_apiculture/screens/accueil_screen.dart';
import 'package:app_passion_apiculture/screens/user_screen.dart';
import 'package:app_passion_apiculture/screens/commande_screen.dart';
import 'package:app_passion_apiculture/screens/produit_screen.dart';
import 'package:app_passion_apiculture/screens/stat_screen.dart';
import 'package:app_passion_apiculture/screens/stock_screen.dart';


class HomeScreen extends StatefulWidget {

  final int initialIndex; // Nouveau paramètre pour définir l'index initial

  const HomeScreen({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // Utiliser le paramètre initial
  }

@override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context).user;
    final product = Provider.of<ProductProvider>(context).products;

    final List<List> screens = [
      [AccueilScreen(user, product), "Accueil"],
      [ProduitScreen(user), "Catalogue"],
      [CommandeScreen(user), "Commande"],
      [StockScreen(user), "Stock"],
      [StatScreen(user), "Statistique"]
  ];

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/logo-site.png'),
        title: Text(screens[_currentIndex][1]),
         actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.account_circle,
              color: Color.fromARGB(255, 249, 177, 20),
              size: 40,
            ),
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
      body: screens[_currentIndex][0], // Change le contenu ici
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
    BottomNavigationBarItem(
      icon: _buildIcon(Icons.home, 0),
      label: 'Accueil',
    ),
    BottomNavigationBarItem(
      icon: _buildIcon(Icons.view_list, 1),
      label: 'Catalogue',
    ),
    BottomNavigationBarItem(
      icon: _buildIcon(Icons.storefront, 2),
      label: 'Commande',
    ),
    BottomNavigationBarItem(
      icon: _buildIcon(Icons.inventory_2, 3),
      label: 'Stock',
    ),
    BottomNavigationBarItem(
      icon: _buildIcon(Icons.trending_up, 4),
      label: 'Statistique',
    ),
  ],
      ),
    );
  }

Widget _buildIcon(IconData iconData, int index) {
  if (_currentIndex == index) {
    // Si l'élément est sélectionné, afficher un cercle autour de l'icône
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(200),
        color: Color.fromARGB(255, 249, 177, 20),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8), // Optionnel : espace entre l'icône et le contour
      child: Icon(
        size: 30,
        iconData,
        color: Colors.black,
      ),
    );
  } else {
    // Si l'élément n'est pas sélectionné, afficher simplement l'icône
    return Icon(
      iconData,
      color: Colors.grey,
    );
  }
}
}