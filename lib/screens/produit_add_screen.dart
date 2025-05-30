import 'package:app_passion_apiculture/models/user.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:app_passion_apiculture/providers/type_provider.dart';
import 'package:app_passion_apiculture/services/product_services.dart';
import 'package:app_passion_apiculture/models/product.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProduitAddScreen extends StatefulWidget {
  final User user;

  const ProduitAddScreen(this.user, {Key? key}) : super(key: key);

  @override
  State<ProduitAddScreen> createState() => _ProduitAddScreenState();
}

class _ProduitAddScreenState extends State<ProduitAddScreen> {
  late TextEditingController titleController;
  late TextEditingController prixController;
  late TextEditingController descripController;
  late TextEditingController caractController;
  late TextEditingController stockController;
  String? selectedType;

  void addProduct() async {
    // Vérifier que tous les champs sont remplis
    if (titleController.text.isEmpty ||
        prixController.text.isEmpty ||
        descripController.text.isEmpty ||
        stockController.text.isEmpty ||
        selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez remplir tous les champs'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final product = Product(
      id: '',
      title: titleController.text,
      descrip: descripController.text,
      caracteristique: caractController.text,
      prix: prixController.text,
      type: selectedType!,
      libelleType: '',
      minia: 'No_Image',
      stock: int.tryParse(stockController.text) ?? 0,
      createAt: '',
      updateAt: '',
    );

    bool status = await ProductServices().addProduct(
      context: context,
      token: widget.user.token,
      product: product,
    );

    print(status);

    if (status) {
      setState(() {
        titleController.clear();
        prixController.clear();
        descripController.clear();
        caractController.clear();
        stockController.clear();
        selectedType = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Produit ajouté avec succès (veuillez vous reconnecter pour le voir)'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de l\'ajout du produit'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    prixController = TextEditingController();
    descripController = TextEditingController();
    caractController = TextEditingController();
    stockController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    prixController.dispose();
    descripController.dispose();
    caractController.dispose();
    stockController.dispose();
    super.dispose();
  }

  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    final typeProvider = Provider.of<TypeProvider>(context);
    final types = typeProvider.types;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un produit'),
        backgroundColor: const Color.fromARGB(255, 249, 177, 20),
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
                        controller: prixController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d\.]'))],
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
                      TextField(
                        controller: stockController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                          labelText: 'Stock',
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (types.isNotEmpty)
                        DropdownButtonFormField<String>(
                          value: selectedType,
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
                            labelText: 'Type',
                          ),
                          items: types.map((type) {
                            return DropdownMenuItem<String>(
                              value: type.id,
                              child: Text(type.libelle),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedType = newValue;
                            });
                          },
                        )
                      else
                        Text('Aucun type disponible'),
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
                  margin: EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        addProduct();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 249, 177, 20),
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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