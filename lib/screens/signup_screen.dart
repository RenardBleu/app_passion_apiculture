import 'package:flutter/material.dart';

class SignupSreen extends StatelessWidget {
  const SignupSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Simple Screen")),
      body: const Center(
        child: Text(
          "Bonjour, ceci est un écran simple !",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}