import 'dart:convert';

class Type {
  final String id;
  final String libelle;
  Type({
    required this.id,
    required this.libelle,
  });

   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'libelle': libelle,
    };
  }

/*   factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['product']['id'].toString() ?? '',
      title: map['product']['title'] ?? '',
      descrip: map['product']['description'] ?? '',
      prix: map['product']['prix'].toString() ?? '',
      idType: map['product']['idType'].toString() ?? '',
      minia: map['product']['miniature'] ?? '',
      createAt: map['product']['CreateAt'] ?? '',
      updateAt: map['product']['UpdateAt'] ?? ''
    );
  } */
   factory Type.fromMap(Map<String, dynamic> map) {
    
    return Type(
      id: map['id'].toString(),
      libelle: map['libelle'] ?? '',
    );
  }

  static List<Type> fromJson(String source) {
    final Map<String, dynamic> data = json.decode(source);
    final List<dynamic> typesJson = data['type'];
    return typesJson.map((json) => Type.fromMap(json)).toList();
  }

  String toJson() => json.encode(toMap());
}