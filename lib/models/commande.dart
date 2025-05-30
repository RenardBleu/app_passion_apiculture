import 'dart:convert';

class Commande {
  final String num;
  final String idUser;
  final String nom;
  final String prenom;
  final String idTag;
  final String tagLibelle;
  final String montant;
  final String updateAt;
  final String createAt;

  Commande({
    required this.num,
    required this.idUser,
    required this.nom,
    required this.prenom,
    required this.idTag,
    required this.tagLibelle,
    required this.montant,
    required this.updateAt,
    required this.createAt,
  });

   Map<String, dynamic> toMap() {
    return {
      'num': num,
      'idUser': idUser,
      'nom': nom,
      'prenom': prenom,
      'idTag': idTag,
      'tagLibelle': tagLibelle,
      'montant': montant,
      'updateAt': updateAt,
      'createAt': createAt,
    };
  }
   factory Commande.fromMap(Map<String, dynamic> map) {
    print("===============================9849898");
    print(map);
    print("======================================");
    return Commande(
      num: map['num'].toString(),
      idUser: map['idUser'].toString(),
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      idTag: map['idTag'].toString(),
      tagLibelle: map['tagLibelle'].toString(),
      montant: map['montant'].toString(),
      updateAt: map['updateAt'] ?? '',
      createAt: map['createAt'] ?? '',
    );
  }

  static List<Commande> fromJson(String source) {
    final Map<String, dynamic> data = json.decode(source);
    final List<dynamic> commandesJson = data['commande'];
    //print(commandesJson);
    return commandesJson.map((json) => Commande.fromMap(json)).toList();
  }

  String toJson() => json.encode(toMap());
}