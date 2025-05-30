import 'package:app_passion_apiculture/models/product.dart';
import 'package:app_passion_apiculture/services/product_services.dart';
import 'package:app_passion_apiculture/models/user.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:app_passion_apiculture/providers/type_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; 

class ProductEditScreen extends StatefulWidget {
  final Product product; 
  final User user;

  const ProductEditScreen(this.user, this.product, {Key? key}) : super(key: key);

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  late TextEditingController titleController;
  late TextEditingController prixController;
  late TextEditingController descripController;
  late TextEditingController caractController;
  String? selectedType;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.product.title);
    prixController = TextEditingController(text: widget.product.prix);
    descripController = TextEditingController(text: widget.product.descrip);
    caractController = TextEditingController(text: widget.product.caracteristique);
    selectedType = widget.product.type;
  }

  void editProduct() async {
    // Mettre à jour les valeurs du produit

    final Product oldProduct = widget.product;

    setState(() {
      widget.product.title = titleController.text;
      widget.product.prix = prixController.text;
      widget.product.descrip = descripController.text;
      widget.product.caracteristique = caractController.text;
      widget.product.type = selectedType ?? widget.product.type;
    });

     final products = await ProductServices().editProduct(
      context: context,
      token: widget.user.token,
      product: widget.product,
    );

    if (!products) {
      setState(() {
        widget.product.title = oldProduct.title;
        widget.product.prix = oldProduct.prix;
        widget.product.descrip = oldProduct.descrip;
        widget.product.caracteristique = oldProduct.caracteristique;
        widget.product.type = selectedType ?? oldProduct.type;
      });

      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erreur lors de l\'edition du produit'),
        backgroundColor: Colors.red,
      ),
    );
    }else{
      // Afficher un message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Produit modifié avec succès'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    prixController.dispose();
    descripController.dispose();
    caractController.dispose();
    super.dispose();
  }

  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  String formatDate(String? isoDate) {
    if (isoDate == null || isoDate.isEmpty) {
      return "Date invalide";
    }
    try {
      DateTime dateTime = DateTime.parse(isoDate);
      return DateFormat('dd/MM/yyyy - HH:mm').format(dateTime);
    } catch (e) {
      return "Format de date invalide";
    }
  }

  @override
  Widget build(BuildContext context) {
    final typeProvider = Provider.of<TypeProvider>(context);
    final types = typeProvider.types;

    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier le produit'),
        backgroundColor: const Color.fromARGB(255, 249, 177, 20),
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Affichage du produit actuel
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
                      Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          widget.product.minia != "No_Image"
                              ? Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://renardserveur.freeboxos.fr/e-commerce-alexis/public/${widget.product.minia}',
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
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.product.title,
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '${widget.product.prix} €',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  widget.product.libelleType,
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
                      SizedBox(height: 20),
                      Text(
                        "Description :",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.product.descrip,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 10),
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
                            formatDate(widget.product.updateAt),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Formulaire de modification
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
                      if (types.isNotEmpty)
                        DropdownButtonFormField<String>(
                          value: types.any((type) => type.id == selectedType) ? selectedType : null,
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
                        "Pour modifier l'image, veuillez vous rendre sur la version web.*",
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
                        // TODO: Implémenter la sauvegarde
                        editProduct();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 249, 177, 20),
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: const Text(
                        'Modifier',
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