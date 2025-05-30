import 'dart:convert';

class Tag {
  final String id;
  final String libelle;
  Tag({
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
   factory Tag.fromMap(Map<String, dynamic> map) {
    
    return Tag(
      id: map['id'].toString(),
      libelle: map['libelle'] ?? '',
    );
  }

  static List<Tag> fromJson(String source) {
    final Map<String, dynamic> data = json.decode(source);
    final List<dynamic> tagsJson = data['tag'];
    return tagsJson.map((json) => Tag.fromMap(json)).toList();
  }

  String toJson() => json.encode(toMap());
}