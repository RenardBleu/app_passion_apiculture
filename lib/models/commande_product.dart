import 'dart:convert';

class CommandeProduct {
  final String num_commande;
  final String nom_produit;
  final String prix_produit;
  final String minia_produit;
  final String libelle_produit;
  final String quantite;

  CommandeProduct({
    required this.num_commande,
    required this.nom_produit,
    required this.prix_produit,
    required this.minia_produit,
    required this.libelle_produit,
    required this.quantite,
  });

  Map<String, dynamic> toMap() {
    return {
      'num_commande': num_commande,
      'nom_produit': nom_produit,
      'prix_produit': prix_produit,
      'libelle_produit': libelle_produit,
      'minia_produit': minia_produit,
      'quantite': quantite,
    };
  }

  factory CommandeProduct.fromMap(Map<String, dynamic> map) {
    print("++++++++++++++++++++++++++++++++++++++");
    print(map);
    print("======================================");
    return CommandeProduct(
      num_commande: map['num_commande'].toString(),
      nom_produit: map['nom_produit'] ?? '',
      prix_produit: map['prix_produit'].toString(),
      libelle_produit: map['libelle_produit'] ?? '',
      minia_produit: map['minia_produit'] ?? '',
      quantite: map['quantite'].toString(),
    );
  }

  static List<CommandeProduct> fromJson(String source) {
    final Map<String, dynamic> data = json.decode(source);
    final List<dynamic> productsJson = data['commandeProducts'];
    return productsJson.map((json) => CommandeProduct.fromMap(json)).toList();
  }

  String toJson() => json.encode(toMap());
} 