import 'package:app_passion_apiculture/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class BasicTestScreen extends StatelessWidget {
  const BasicTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Screen")
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.email)
          ],
        )
      ),
    );
  }
}