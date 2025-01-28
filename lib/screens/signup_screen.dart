import 'package:app_passion_apiculture/screens/login_screen.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>{
  
  final AuthServices authServices = AuthServices();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();

  

  void SignIn(){
    authServices.signInUser(
      context: context, 
      email: emailController.text, 
      password: passwordController.text, 
      nom: nomController.text, 
      prenom: prenomController.text,
      createAt: ''
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Passion apiculture",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Bienvenue à vous!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nomController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nom',
                prefixIcon: Icon(Icons.account_circle_rounded),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: prenomController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Prenom',
                prefixIcon: Icon(Icons.account_circle_rounded),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print("Test email :");
                print(emailController.text);
                print(nomController.text);
                print(prenomController.text);
                print(passwordController.text);
                SignIn();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('S\'inscire'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              }, child: Text('Se connecter'),
            )
          ],
        ),
      ),
    );
  }
}