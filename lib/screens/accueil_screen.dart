import 'package:app_passion_apiculture/models/product.dart';
import 'package:app_passion_apiculture/models/user.dart';
import 'package:app_passion_apiculture/screens/home_screen.dart';
import 'package:app_passion_apiculture/screens/produit_edit_screen.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:flutter/material.dart';

class AccueilScreen extends StatelessWidget {

  final User user;
  
  final List<Product> products; 

  const AccueilScreen(this.user, this.products, {Key? key}) : super(key: key);
  
  get context => null;

  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  /* void GetProduct(BuildContext contex){
    ProductServices().getProduct(token: user.token, context: null);
  } */

  @override
  Widget build(BuildContext context) {

  final List<String> name = <String>['Agathe Jost | Miel lavande', 'Pierre chabrier | Cristaux de menthe', 'Alexis Labaste | de l\'inspi'];
  final List<String> status = ["Livraison en cours", "Commande passé", "Commande en préparation"];
  final List<Product> recentProduits = [products[0], products[1]];

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
                          decoration: BoxDecoration(
                            boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(40, 0, 0, 0),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                   offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(name[index]),
                                subtitle: Text(status[index]),
                                leading: Icon(Icons.shopping_cart),
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
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: 
                          ElevatedButton(
                          onPressed: () {
                            print(products[1].title);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 249, 177, 20),
                          ),
                          child: const Text(
                            'Voir yoooo',
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