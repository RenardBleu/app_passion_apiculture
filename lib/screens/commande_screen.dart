import 'package:app_passion_apiculture/models/user.dart';
import 'package:app_passion_apiculture/screens/commande_edit_screen.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:flutter/material.dart';

class CommandeScreen extends StatelessWidget {
  final User user;
  final dynamic commandes;

  const CommandeScreen(this.user, this.commandes, {Key? key}) : super(key: key);

  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  Map<String, dynamic> getStatusStyle(String tagLibelle) {
    switch (tagLibelle.toLowerCase()) {
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
  Widget build(BuildContext context) {
    final List<dynamic> recentCommandes = commandes;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recentCommandes.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CommandeEditScreen(user, commandes[index])),
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: getStatusStyle(
                                    recentCommandes[index].tagLibelle)['color']
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            getStatusStyle(
                                recentCommandes[index].tagLibelle)['icon'],
                            color: getStatusStyle(
                                recentCommandes[index].tagLibelle)['color'],
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${recentCommandes[index].nom} ${recentCommandes[index].prenom}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: getStatusStyle(
                                              recentCommandes[index]
                                                  .tagLibelle)['color']
                                          .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      recentCommandes[index].tagLibelle,
                                      style: TextStyle(
                                        color: getStatusStyle(
                                            recentCommandes[index]
                                                .tagLibelle)['color'],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                'N° ${recentCommandes[index].num}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '${recentCommandes[index].montant} €',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
