import 'package:app_passion_apiculture/providers/user_provider.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:app_passion_apiculture/screens/login_screen.dart';
import 'package:app_passion_apiculture/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}): super(key: key);

  @override
  State<MyApp> createState() => _MyappState();
}

class _MyappState extends State<MyApp>{
  final AuthServices authServices = AuthServices();

  @override
  void initState(){
    super.initState();
    authServices.getUserData(context);
  }


   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Passion Apiculture',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Provider.of<UserProvider>(context).user.token.isEmpty ? const LoginScreen(): HomeScreen() ,
    );
  }
}