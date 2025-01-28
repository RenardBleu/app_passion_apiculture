import 'dart:ui';

import 'package:app_passion_apiculture/models/user.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {

  final User user; 

  const UserScreen(this.user, {Key? key}) : super(key: key);

  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Mon profil"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 221, 221, 221),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.account_circle, 
                    size: 150,
                    color: const Color.fromARGB(255, 249, 177, 20),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textAlign: TextAlign.start,
                          user.nom, 
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          user.prenom,
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => signOutUser(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Se déconnecter'),
            ),
          ],
        )
      )
    );
  }
}