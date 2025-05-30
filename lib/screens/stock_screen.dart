import 'package:app_passion_apiculture/models/user.dart';
import 'package:app_passion_apiculture/models/product.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:app_passion_apiculture/services/product_services.dart';
import 'package:flutter/material.dart';

class StockScreen extends StatefulWidget {
  final User user;
  final dynamic products;


  const StockScreen(this.user, this.products, {Key? key}) : super(key: key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {

  void updateStock(Product product, int delta, int index) async {
    // Sauvegarder l'ancienne valeur au cas où il faudrait revenir en arrière
    final oldStock = product.stock;
    
    // Mettre à jour l'UI immédiatement
    setState(() {
      product.stock += delta;
      if (product.stock < 0) product.stock = 0;
    });

    // Appeler l'API pour mettre à jour le stock
    bool status = await ProductServices().updateStock(
      context: context,
      token: widget.user.token,
      productId: product.id,
      stock: product.stock,
    );

    // Si l'appel API a échoué, revenir à l'ancienne valeur
    if (!status) {
      setState(() {
        product.stock = oldStock;
      });
    }
  }

  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          final product = widget.products[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: product.minia != 'No_Image'
                ? Image.network(
                  'https://renardserveur.freeboxos.fr/e-commerce-alexis/public/${product.minia}',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover
                ):
                Icon(Icons.image, size: 60, color: Colors.grey)
              ),
              title: Text(product.title, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Stock : ${product.stock}', style: TextStyle(fontSize: 16)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () => updateStock(product, -1, index),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_circle, color: Colors.green),
                    onPressed: () => updateStock(product, 1, index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}