import 'package:app_passion_apiculture/models/user.dart';
import 'package:app_passion_apiculture/providers/user_provider.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

/*class BasicTest2Screen extends StatelessWidget {
  const BasicTest2Screen({Key? key}) : super(key: key);

  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("basic screen")
        ),


        
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.email),
            ElevatedButton(
              onPressed: () => signOutUser(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Se déconnecter'),
            ),
          ],
        )
      ),
    );
  }
}*/

// Les différents écrans
class BasicTestScreen extends StatelessWidget {
  final User user; 

  const BasicTestScreen(this.user, {Key? key}) : super(key: key);

  void signOutUser(BuildContext context) {
    AuthServices().signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.email),
            ElevatedButton(
              onPressed: () => signOutUser(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Se déconnecter'),
            ),
          ],
        )
      );
  }
}