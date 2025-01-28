import 'package:app_passion_apiculture/models/user.dart';
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

    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  //color: Colors.red,
                  margin: EdgeInsets.only(top: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [





                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
                            width: 185,
                            height: 300,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 221, 221, 221),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(50, 0, 0, 0),
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





                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
                              width: 185,
                              height: 300,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 221, 221, 221),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(50, 0, 0, 0),
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




                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: 
                          ElevatedButton(
                          onPressed: () {
                            
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
                )
              ],
            ),
          ],
        )
      );
  }
}