import 'package:app_passion_apiculture/models/product.dart';
import 'package:app_passion_apiculture/models/commande.dart';
import 'package:app_passion_apiculture/models/user.dart';
import 'package:app_passion_apiculture/screens/home_screen.dart';
import 'package:app_passion_apiculture/screens/produit_edit_screen.dart';
import 'package:app_passion_apiculture/screens/commande_edit_screen.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:flutter/material.dart';

class AccueilScreen extends StatelessWidget {

  final User user;
  
  final List<Product> products; 
  final List<Commande> commandes;


  const AccueilScreen(this.user, this.products, this.commandes, {Key? key}) : super(key: key);
  
  get context => null;

  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  /* void GetProduct(BuildContext contex){
    ProductServices().getProduct(token: user.token, context: null);
  } */

  Map<String, dynamic> getStatusStyle(String tagLibelle) {
    switch (tagLibelle.toLowerCase()) {
      case 'en attente':
        return {
          'color': Colors.orange,
          'icon': Icons.hourglass_empty,
        };
      case 'en préparation':
        return {
          'color': Colors.blue,
          'icon': Icons.restaurant,
        };
      case 'payée':
        return {
          'color': Colors.green,
          'icon': Icons.payment,
        };
      case 'livrée':
        return {
          'color': Colors.purple,
          'icon': Icons.check_circle,
        };
      case 'annulée':
        return {
          'color': Colors.red,
          'icon': Icons.cancel,
        };
      case 'en cours de livraison':
        return {
          'color': Colors.teal,
          'icon': Icons.local_shipping,
        };
      default:
        return {
          'color': Colors.grey,
          'icon': Icons.shopping_cart,
        };
    }
  }

  @override
  Widget build(BuildContext context) {
  
  // Prendre les 2 premiers produits s'ils existent
  final List<Product> recentProduits = products.length >= 2 
      ? [products[0], products[1]]
      : products;

  // Prendre les 3 premières commandes s'ils existent
  final List<Commande> recentCommandes = commandes.length >=3 
      ? commandes.take(3).toList()
      : commandes;

    return 
    ListView(
      children: [
        Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  //color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      


                      //--------------- PRODUIT RECENT SECTION ---------------//



                      // -- TITRE --
                      Row(
                        children: [
                          Icon(
                            Icons.view_list,
                            size: 40,
                            color: const Color.fromARGB(255, 249, 177, 20)
                          ),
                          Text(
                            "Produit récent :",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    

                      // -- CONTENT --
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var produit in recentProduits)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductEditScreen(user, produit),
                                  ),
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 3,
                                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: Container(
                                  width: 170, // Forcer la largeur à 170
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                        child: produit.minia != 'No_Image'
                                            ? Image.network(
                                                'https://renardserveur.freeboxos.fr/e-commerce-alexis/public/${produit.minia}',
                                                height: 140,
                                                width: 170,
                                                fit: BoxFit.cover,
                                              )
                                            : Container(
                                                height: 140,
                                                width: 170,
                                                color: const Color.fromARGB(255, 249, 177, 20),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.image,
                                                    size: 80,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          width: 170,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                produit.title,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                '${produit.prix} €',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                produit.libelleType,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black45,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),


                      // -- BTN --
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: 
                          ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen(initialIndex: 1,)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 249, 177, 20),
                          ),
                          child: const Text(
                            'Voir plus',
                            style: TextStyle(
                              color: Colors.black,
                            )
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                


                //--------------- COMMANDE EN COURS SECTION ---------------//



                Container(
                  //color: Colors.red,
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.storefront,
                            size: 40,
                            color: const Color.fromARGB(255, 249, 177, 20)
                          ),
                          Text(
                            "Commande en cours :",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: recentCommandes.length,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => CommandeEditScreen(user, recentCommandes[index])),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: getStatusStyle(recentCommandes[index].tagLibelle)['color'].withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Icon(
                                            getStatusStyle(recentCommandes[index].tagLibelle)['icon'],
                                            color: getStatusStyle(recentCommandes[index].tagLibelle)['color'],
                                          ),
                                        ),
                                        SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    '${recentCommandes[index].nom} ${recentCommandes[index].prenom}',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                    decoration: BoxDecoration(
                                                      color: getStatusStyle(recentCommandes[index].tagLibelle)['color'].withOpacity(0.2),
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    child: Text(
                                                      recentCommandes[index].tagLibelle,
                                                      style: TextStyle(
                                                        color: getStatusStyle(recentCommandes[index].tagLibelle)['color'],
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                'N° ${recentCommandes[index].num}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                '${recentCommandes[index].montant} €',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: 
                          ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomeScreen(initialIndex: 2,)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 249, 177, 20),
                          ),
                          child: const Text(
                            'Voir plus',
                            style: TextStyle(
                              color: Colors.black,
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
      ),
      ]
    );
  }
}