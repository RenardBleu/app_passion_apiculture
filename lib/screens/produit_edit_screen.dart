import 'package:app_passion_apiculture/models/product.dart';
import 'package:app_passion_apiculture/models/user.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ProductEditScreen extends StatelessWidget {

  final Product product; 
  final User user;

  const ProductEditScreen(this.user, this.product, {Key? key}) : super(key: key);

  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  String formatDate(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) {
      return "Date invalide"; // Gérer les dates nulles ou vides
    }
    try {
      DateTime dateTime = DateTime.parse(isoDate);
      return DateFormat('dd/MM/yyyy - HH:mm').format(dateTime);
    } catch (e) {
      return "Format de date invalide"; // Gérer les erreurs de format
    }
  }

  @override
  Widget build(BuildContext context) {

    final TextEditingController titleController = TextEditingController(text : product.title);
    final TextEditingController prixController = TextEditingController(text: product.prix);
    final TextEditingController descripController = TextEditingController(text: product.descrip);
    final TextEditingController caractController = TextEditingController(text: product.caracteristique);
    final String typeController = product.type;

    const List<String> list = <String>['miel', 'bougie', 'autre'];

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          product.minia != "No_Image"
                              ? Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://renardserveur.freeboxos.fr/e-commerce-alexis/public/${product.minia}',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                              )
                              : Icon(
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
                                    fontWeight: FontWeight.normal,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description :",
                            style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            ),
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
                                'Dernière modification : ',
                                style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                formatDate(product.updateAt),
                                style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: 
                  Text(
                    "Statistique du produit : ",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
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
                      Text(
                            "Aucun système de stat pour le moment",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                    ],
                  )
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: 
                  Text(
                    "Modifier le produit : ",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
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
                      TextField(
                        controller: titleController,
                        cursorColor: Color.fromARGB(255, 249, 177, 20),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                          focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(80, 249, 177, 20), width: 5),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Nom',
                          //prefixIcon: Icon(Icons.email, color: Colors.black,),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [ FilteringTextInputFormatter.allow(RegExp(r'[\d\.]'))], 
                        controller: prixController,
                        cursorColor: Color.fromARGB(255, 249, 177, 20),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                          focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(80, 249, 177, 20), width: 5),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Prix',
                          //prefixIcon: Icon(Icons.lock, color: Colors.black,),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: descripController,
                        cursorColor: Color.fromARGB(255, 249, 177, 20),
                        maxLines: 6,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                          focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(80, 249, 177, 20), width: 5),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Description',
                          //prefixIcon: Icon(Icons.email, color: Colors.black,),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: caractController,
                        cursorColor: Color.fromARGB(255, 249, 177, 20),
                        maxLines: 6,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                          focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(80, 249, 177, 20), width: 5),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Caractéristique (séparer les données par des //)',
                          //prefixIcon: Icon(Icons.email, color: Colors.black,),
                        ),
                      ),
                      const SizedBox(height: 20),
                      DropdownMenu<String>(
                        inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        initialSelection: list.contains(typeController) ? typeController : null,
                        onSelected: (String? value) {
                          print(value);
                        },
                        dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(value: value, label: value);
                        }).toList(),
                      ),
                      Text(
                        "Pour modifier ou ajouter une image, veuillez vous rendre sur la version web.*",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  )
                ),
                Container(
                  child: 
                  Center(
                    child: 
                    ElevatedButton(
                    onPressed: () {
                      print(typeController);
                    },
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
                  )
                )
              ],
            )
          )
        ],
      )
    );
  }
}