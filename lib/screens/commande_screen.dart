import 'package:app_passion_apiculture/models/user.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:flutter/material.dart';

class CommandeScreen extends StatelessWidget {

  final User user; 

  const CommandeScreen(this.user, {Key? key}) : super(key: key);

  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  @override
  Widget build(BuildContext context) {

    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Commande",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        )
      );
  }
}