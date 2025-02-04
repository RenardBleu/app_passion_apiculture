import 'package:app_passion_apiculture/models/product.dart';
import 'package:app_passion_apiculture/models/user.dart';
import 'package:app_passion_apiculture/screens/home_screen.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:app_passion_apiculture/services/product_services.dart';
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

                              Container(
                                margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
                                width: 170,
                                height: 300,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 221, 221, 221),
                                  boxShadow: [
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