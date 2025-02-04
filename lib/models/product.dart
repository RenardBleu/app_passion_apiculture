import 'dart:convert';

class Product {
  final String id;
  final String title;
  final String descrip;
  final String prix;
  final String type;
  final String minia;
  final String createAt;
  final String updateAt;
  Product({
    required this.id,
    required this.title,
    required this.descrip,
    required this.prix,
    required this.type,
    required this.minia,
    required this.createAt,
    required this.updateAt
  });

   Map<String, dynamic> toMap() {
    return {
      'title': title,
      'descrip': descrip,
      'prix': prix,
      'idType': type,
      'minia': minia,
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
    print("======================================");
    print(map);
    print("======================================");
    return Product(
      id: map['id'].toString(),
      title: map['title'] ?? '',
      descrip: map['description'],
      prix: map['prix'].toString(),
      type: map['type'].toString(),
      minia: map['miniature'] ?? '',
      updateAt: map['UpdateAt'] ?? '',
      createAt: map['CreateAt'] ?? '',
    );
  }

  static List<Product> fromJson(String source) {
    final Map<String, dynamic> data = json.decode(source);
    final List<dynamic> productsJson = data['product'];
    return productsJson.map((json) => Product.fromMap(json)).toList();
  }

  String toJson() => json.encode(toMap());
}