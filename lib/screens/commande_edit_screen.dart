import 'package:app_passion_apiculture/models/commande.dart';
import 'package:app_passion_apiculture/models/user.dart';
import 'package:app_passion_apiculture/models/tag.dart';
import 'package:app_passion_apiculture/models/commande_product.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:app_passion_apiculture/services/commande_services.dart';
import 'package:app_passion_apiculture/providers/tag_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; 

class CommandeEditScreen extends StatefulWidget {
  final User user;
  final Commande commande;

  const CommandeEditScreen(this.user, this.commande, {Key? key}) : super(key: key);

  @override
  State<CommandeEditScreen> createState() => _CommandeEditScreenState();
}

class _CommandeEditScreenState extends State<CommandeEditScreen> {
  String? selectedStatus;
  List<CommandeProduct> commandeProducts = [];
  bool isLoading = true;

  Map<String, dynamic> getStatusStyle(String status) {
    switch (status.toLowerCase()) {
      case 'en attente':
        return {
          'color': Colors.orange,
          'icon': Icons.hourglass_empty,
        };
      case 'en préparation':
        return {
          'color': Colors.blue,
          'icon': Icons.restaurant,
        };
      case 'payée':
        return {
          'color': Colors.green,
          'icon': Icons.payment,
        };
      case 'livrée':
        return {
          'color': Colors.purple,
          'icon': Icons.check_circle,
        };
      case 'annulée':
        return {
          'color': Colors.red,
          'icon': Icons.cancel,
        };
      case 'en cours de livraison':
        return {
          'color': Colors.teal,
          'icon': Icons.local_shipping,
        };
      default:
        return {
          'color': Colors.grey,
          'icon': Icons.shopping_cart,
        };
    }
  }

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.commande.idTag;
    _loadCommandeProducts();
  }

  Future<void> _loadCommandeProducts() async {
    setState(() {
      isLoading = true;
    });

    final products = await CommandeProductServices().getCommandeProducts(
      context: context,
      token: widget.user.token,
      commandeNum: widget.commande.num,
    );

    setState(() {
      commandeProducts = products;
      isLoading = false;
    });
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
      return DateFormat('dd/MM/yyyy - HH:mm').format(dateTime.toLocal());
    } catch (e) {
      return "Format de date invalide";
    }
  }

  @override
  Widget build(BuildContext context) {

    final tagProvider = Provider.of<TagProvider>(context);
    final tags = tagProvider.tags;

    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la commande'),
        backgroundColor: const Color.fromARGB(255, 249, 177, 20),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête de la commande
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Commande',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'N° ${widget.commande.num}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: getStatusStyle(widget.commande.tagLibelle)['color'].withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  getStatusStyle(widget.commande.tagLibelle)['icon'],
                                  color: getStatusStyle(widget.commande.tagLibelle)['color'],
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  widget.commande.tagLibelle,
                                  style: TextStyle(
                                    color: getStatusStyle(widget.commande.tagLibelle)['color'],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Client: ${widget.commande.nom} ${widget.commande.prenom}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Date: ${formatDate(widget.commande.createAt)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Total: ${widget.commande.montant} €',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Statut de la commande
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Modifier le statut',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      const SizedBox(height: 20),
                      if (tags.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedStatus,
                              isExpanded: true,
                              items: tags.map((Tag tag) {
                                return DropdownMenuItem<String>(
                                  value: tag.id,
                                  child: Row(
                                    children: [
                                      Icon(
                                        getStatusStyle(tag.libelle)['icon'],
                                        color: getStatusStyle(tag.libelle)['color'],
                                      ),
                                      SizedBox(width: 8),
                                      Text(tag.libelle),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedStatus = newValue;
                                  });
                                }
                              },
                            ),
                          ),
                        )
                      else
                        Text('Aucun tag disponible'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Liste des produits
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Produits commandés',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      if (isLoading)
                        Center(child: CircularProgressIndicator())
                      else if (commandeProducts.isEmpty)
                        Center(
                          child: Text(
                            'Aucun produit dans cette commande',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: commandeProducts.length,
                          itemBuilder: (context, index) {
                            final produit = commandeProducts[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: produit.minia_produit != 'No_Image'
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Image.network(
                                              'https://renardserveur.freeboxos.fr/e-commerce-alexis/public/${produit.minia_produit}',
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Icon(
                                            Icons.image,
                                            color: Colors.grey[400],
                                          ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          produit.nom_produit,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Quantité: ${produit.quantite}',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        Text(
                                          produit.libelle_produit,
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${(double.parse(produit.prix_produit) * double.parse(produit.quantite)).toStringAsFixed(2)} €',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}