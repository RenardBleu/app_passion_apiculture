import 'dart:convert';

class User {
  final String id;
  final String nom;
  final String prenom;
  final String email;
  final String token;
  final String password;
  final String createAt;
  User({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.token,
    required this.password,
    required this.createAt
  });

   Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'token': token,
      'password': password,
      'createAt': createAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['user']['id'].toString(),
      nom: map['user']['nom'] ?? '',
      prenom: map['user']['prenom'] ?? '',
      email: map['user']['email'] ?? '',
      token: map['token'] ?? '',
      password: map['user']['password'] ?? '',
      createAt: map['user']['CreateAt'] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}