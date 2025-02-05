import 'package:app_passion_apiculture/models/product.dart';
import 'package:app_passion_apiculture/models/user.dart';
import 'package:app_passion_apiculture/screens/produit_edit_screen.dart';
import 'package:app_passion_apiculture/screens/produit_add_screen.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:flutter/material.dart';

class ProduitScreen extends StatelessWidget {

  final User user;
  
  final dynamic products; 

  const ProduitScreen(this.user, this.products, {Key? key}) : super(key: key);
  

  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  @override
  Widget build(BuildContext context) {

    final List<Product> recentProduits = products;

    return 
    Stack(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.57,
              children: [
                for (var produit in recentProduits)
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 221, 221, 221),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(40, 0, 0, 0),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: 
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                            MaterialPageRoute(builder: (context) => ProductEditScreen(user, produit)),
                        );
                      },
                      elevation: 0.0,
                      backgroundColor: Color.fromARGB(255, 221, 221, 221),
                      child: 
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.image,
                                size: 140,
                                color: const Color.fromARGB(255, 249, 177, 20),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    produit.title,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${produit.prix} €',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        produit.type,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 249, 177, 20),
              onPressed: () {
                Navigator.push(
                  context,
                    MaterialPageRoute(builder: (context) => ProduitAddScreen(user)),
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      );
  }
}