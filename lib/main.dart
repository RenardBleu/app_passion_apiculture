import 'package:app_passion_apiculture/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_passion_apiculture/screens/signup_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Passion Apiculture',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const SignupSreen(),
    );
  }
}