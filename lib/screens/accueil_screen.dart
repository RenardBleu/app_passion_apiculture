import 'package:app_passion_apiculture/models/user.dart';
import 'package:app_passion_apiculture/screens/home_screen.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:flutter/material.dart';

class AccueilScreen extends StatelessWidget {

  final User user; 

  const AccueilScreen(this.user, {Key? key}) : super(key: key);

  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  @override
  Widget build(BuildContext context) {

  final List<String> name = <String>['Agathe Jost | Miel lavande', 'Pierre chabrier | Cristaux de menthe', 'Alexis Labaste | de l\'inspi'];
  final List<String> status = ["Livraison en cours", "Commande passé", "Commande en préparation"];

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
                      //B1
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                                      "Product name sdfsdfsd fsfsf", 
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
                                          "300€",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ), 
                                        ),
                                        Text(
                                          "Bougie",
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

                          //B2
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
                                  offset: Offset(0, 3),
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
                                      "Product name", 
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
                                          "xxx€",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ), 
                                        ),
                                        Text(
                                          "categorie name",
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
                      )
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