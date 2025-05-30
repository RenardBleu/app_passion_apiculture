import 'dart:convert';

class Product {
  final String id;
  String title;
  String descrip;
  String caracteristique;
  String prix;
  String type;
  final String minia;
  late int stock;
  final String libelleType;
  final String createAt;
  final String updateAt;
  Product({
    required this.id,
    required this.title,
    required this.descrip,
    required this.caracteristique,
    required this.prix,
    required this.type,
    required this.libelleType,
    required this.minia,
    required this.stock,
    required this.createAt,
    required this.updateAt
  });

   Map<String, dynamic> toMap() {
    return {
      'title': title,
      'descrip': descrip,
      'caracteristiques': caracteristique,
      'prix': prix,
      'idType': type,
      'libelletype': libelleType,
      'minia': minia,
      'stock': stock,
      'createAt': createAt,
      'updateAt': updateAt,
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
   factory Product.fromMap(Map<String, dynamic> map) {
    print("======================================0");
    print(map);
    print("======================================");
    return Product(
      id: map['id']?.toString() ?? '',
      title: map['title'] ?? '',
      descrip: map['description'] ?? '',
      caracteristique: map['caracteristiques'] ?? '',
      prix: map['prix']?.toString() ?? '',
      type: map['idType']?.toString() ?? '',
      libelleType: map['libelletype'] ?? '',
      minia: map['miniature'] ?? 'No_Image',
      stock: map['stock'] is int ? map['stock'] : int.tryParse(map['stock']?.toString() ?? '0') ?? 0,
      updateAt: map['updateAt'] ?? '',
      createAt: map['createAt'] ?? '',
    );
  }

  static List<Product> fromJson(String source) {
    final Map<String, dynamic> data = json.decode(source);
    final List<dynamic> productsJson = data['product'];
    return productsJson.map((json) => Product.fromMap(json)).toList();
  }

  String toJson() => json.encode(toMap());
}