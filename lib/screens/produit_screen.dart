import 'package:app_passion_apiculture/models/product.dart';
import 'package:app_passion_apiculture/models/user.dart';
import 'package:app_passion_apiculture/screens/produit_edit_screen.dart';
import 'package:app_passion_apiculture/screens/produit_add_screen.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:flutter/material.dart';

class ProduitScreen extends StatelessWidget {
  final User user;

  final dynamic products;

  const ProduitScreen(this.user, this.products, {Key? key}) : super(key: key);

  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> recentProduits = products;

    return Scaffold(
      appBar: AppBar(
        title: Text('Produits'),
        backgroundColor: const Color.fromARGB(255, 249, 177, 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.65,
          ),
          itemCount: recentProduits.length,
          itemBuilder: (context, index) {
            final produit = recentProduits[index];
            return GestureDetector(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                      child: produit.minia != 'No_Image'
                          ? Image.network(
                              'https://renardserveur.freeboxos.fr/e-commerce-alexis/public/${produit.minia}',
                              height: 140,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: 140,
                              width: double.infinity,
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SingleChildScrollView(
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
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 249, 177, 20),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProduitAddScreen(user)),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}