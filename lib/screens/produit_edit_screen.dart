import 'package:app_passion_apiculture/models/product.dart';
import 'package:app_passion_apiculture/models/user.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:flutter/material.dart';

class ProductEditScreen extends StatelessWidget {

  final Product product; 
  final User user;

  const ProductEditScreen(this.user, this.product, {Key? key}) : super(key: key);

  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('${product.title}'),
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
                  width: 400,
                  padding: EdgeInsets.all(20),
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.image, 
                            size: 150,
                            color: const Color.fromARGB(255, 249, 177, 20),
                          ),
                          Expanded( // Permet au texte de prendre l'espace disponible
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start, // Aligne les éléments en haut
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis, // Coupe si dépassement
                                  style: TextStyle(
                                    fontSize: 20, // Ajuste la taille si besoin
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5), // Espacement entre le titre et le prix
                                Text(
                                  '${product.prix} €',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  product.type,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        product.descrip,
                        style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(
                            'dernière modification : ',
                            style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            product.updateAt,
                            style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ),
                Container(
                  margin: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
                  width: 400,
                  padding: EdgeInsets.all(20),
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
                    children: [
                      Row(
                        children: [
                          Text(
                            "qsdqsd le : ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            'xxxx',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "dqsdqd : ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            'sdfsdf',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Text(
                            "Y aura un form ici pour edit le produit : ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                    ],
                  )
                ),
                ElevatedButton(
                  onPressed: () => {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 249, 177, 20),
                  ),
                  child: const Text(
                    'Modifier',
                    style: TextStyle(
                      color: Colors.black,
                    )
                  ),
                ),
              ],
            )
          )
        ],
      )
    );
  }
}