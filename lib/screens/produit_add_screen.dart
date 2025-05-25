import 'package:app_passion_apiculture/models/user.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProduitAddScreen extends StatelessWidget {

  final User user;

  const ProduitAddScreen(this.user, {Key? key}) : super(key: key);

  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  @override
  Widget build(BuildContext context) {

    final TextEditingController titleController = TextEditingController();
    final TextEditingController prixController = TextEditingController();
    final TextEditingController descripController = TextEditingController();
    final TextEditingController caractController = TextEditingController();
    String? typeController;

    const List<String> list = <String>['miel', 'bougie', 'autre'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un produit"),
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        offset: Offset(0, 3),
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
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(80, 249, 177, 20), width: 5),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Nom',
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d\.]'))],
                        controller: prixController,
                        cursorColor: Color.fromARGB(255, 249, 177, 20),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(80, 249, 177, 20), width: 5),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Prix',
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: descripController,
                        cursorColor: Color.fromARGB(255, 249, 177, 20),
                        maxLines: 6,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(80, 249, 177, 20), width: 5),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Description',
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: caractController,
                        cursorColor: Color.fromARGB(255, 249, 177, 20),
                        maxLines: 6,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromARGB(80, 249, 177, 20), width: 5),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Caractéristique (séparer les données par des //)',
                        ),
                      ),
                      const SizedBox(height: 20),
                      DropdownMenu<String>(
                        inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        initialSelection: null,
                        onSelected: (String? value) {
                          typeController = value;
                        },
                        dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(value: value, label: value);
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Pour ajouter une image, veuillez vous rendre sur la version web.*",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        print("Nom: ${titleController.text}");
                        print("Prix: ${prixController.text}");
                        print("Description: ${descripController.text}");
                        print("Caractéristiques: ${caractController.text}");
                        print("Type: $typeController");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 249, 177, 20),
                      ),
                      child: const Text(
                        'Ajouter',
                        style: TextStyle(
                          color: Colors.black,
                        )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}