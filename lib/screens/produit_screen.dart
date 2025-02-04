import 'package:app_passion_apiculture/models/product.dart';
import 'package:app_passion_apiculture/models/user.dart';
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
    GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.57,
        children: [
          for (var produit in recentProduits)

                       Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
                        width: 170,                          
                        height: 300,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 221, 221, 221),                                  boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(40, 0, 0, 0),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                         ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.image, 
                              size: 140,
                              color: const Color.fromARGB(255, 249, 177, 20),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,                                    children: [
                                Text(
                                  textAlign: TextAlign.start,
                                  produit.title, 
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      textAlign: TextAlign.start,
                                      produit.prix,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ), 
                                    ),
                                    Text(
                                      produit.type,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                       ),
                       FloatingActionButton.small(
                  onPressed: () {
                    // Add your onPressed code here!
                  },
                  child: const Icon(Icons.add),
                ),
                ],
              );
  }
}