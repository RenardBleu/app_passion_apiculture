import 'package:app_passion_apiculture/models/user.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserScreen extends StatelessWidget {

  final User user; 

  const UserScreen(this.user, {Key? key}) : super(key: key);

  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  String formatDate(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);

    String formattedDate = DateFormat('d MMMM yyyy').format(dateTime);
    return formattedDate;
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
              margin: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
              width: 400,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 221, 221, 221),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(50, 0, 0, 0),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.account_circle, 
                    size: 150,
                    color: const Color.fromARGB(255, 249, 177, 20),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.start,
                        "compte gérant :", 
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.start,
                        user.nom, 
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        user.prenom,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
              width: 400,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 221, 221, 221),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(50, 0, 0, 0),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Crée le : ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        formatDate(user.createAt),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Email : ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ),
            ElevatedButton(
              onPressed: () => signOutUser(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 249, 177, 20),
              ),
              child: const Text(
                'Se déconnecter',
                style: TextStyle(
                  color: Colors.black,
                )
              ),
            ),
          ],
        )
      )
    );
  }
}