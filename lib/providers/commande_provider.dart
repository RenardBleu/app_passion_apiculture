import 'package:app_passion_apiculture/models/commande.dart';
import 'package:flutter/material.dart';

class CommandeProvider extends ChangeNotifier {
  List<Commande> _commandes = [];

  List<Commande> get commandes => _commandes;

  void setCommandes(String jsonResponse) {
    _commandes = Commande.fromJson(jsonResponse);
    notifyListeners();
  }

  void addCommande(Commande commande) {
    _commandes.add(commande);
    notifyListeners();
  }

  void removeCommande(int num) {
    _commandes.removeWhere((commande) => commande.num == num);
    notifyListeners();
  }

  void updateCommande(Commande updatedCommande) {
    final index = _commandes.indexWhere((commande) => commande.num == updatedCommande.num);
    if (index != -1) {
      _commandes[index] = updatedCommande;
      notifyListeners();
    }
  }
}