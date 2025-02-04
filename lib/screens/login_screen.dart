import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  
  final AuthServices authServices = AuthServices();
  final TextEditingController emailController = TextEditingController(text: 'alexislabaste84100@gmail.com');
  final TextEditingController passwordController = TextEditingController(text: '#Mimi6162oo5@');
  

  void Login(){
    authServices.LoginUser(
      context: context, 
      email: emailController.text, 
      password: passwordController.text, 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo-site.png", scale: 5,),
            const Text(
              "Passion apiculture",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Connectez votre compte administrateur",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              cursorColor: Color.fromARGB(255, 249, 177, 20),
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                enabledBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                focusedBorder:OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(80, 249, 177, 20), width: 5),
                  borderRadius: BorderRadius.circular(10)
                ),
                border: OutlineInputBorder(),
                labelText: 'Email',
                prefixIcon: Icon(Icons.email, color: Colors.black,),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              
              controller: passwordController,
              cursorColor: Color.fromARGB(255, 249, 177, 20),
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                enabledBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                focusedBorder:OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(80, 249, 177, 20), width: 5),
                  borderRadius: BorderRadius.circular(10)
                ),
                border: OutlineInputBorder(),
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock, color: Colors.black,),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print("Test email :");
                print(emailController.text);
                print(passwordController.text);
                Login();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 249, 177, 20),
              ),
              child: const Text(
                'Se connecter',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}