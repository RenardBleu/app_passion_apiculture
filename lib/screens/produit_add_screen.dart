import 'package:app_passion_apiculture/models/user.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:flutter/material.dart';

class ProduitAddScreen extends StatelessWidget {

  final User user;

  const ProduitAddScreen(this.user, {Key? key}) : super(key: key);
  

  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Ajouter un produit"),
        ),
        body: 
      Center(
        child : Text('page test pour add des produit'),
      ),
    );
  }
}