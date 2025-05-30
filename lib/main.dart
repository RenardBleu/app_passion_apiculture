import 'package:app_passion_apiculture/providers/product_provider.dart';
import 'package:app_passion_apiculture/providers/user_provider.dart';
import 'package:app_passion_apiculture/providers/tag_provider.dart';
import 'package:app_passion_apiculture/providers/commande_provider.dart';
import 'package:app_passion_apiculture/providers/type_provider.dart';
import 'package:app_passion_apiculture/services/auth_services.dart';
import 'package:app_passion_apiculture/screens/login_screen.dart';
import 'package:app_passion_apiculture/screens/home_screen.dart';
import 'package:app_passion_apiculture/services/product_services.dart';
import 'package:app_passion_apiculture/services/commande_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => TypeProvider()),
        ChangeNotifierProvider(create: (_) => CommandeProvider()),
        ChangeNotifierProvider(create: (_) => TagProvider()),
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
  bool _isInitialized = false;
  final AuthServices authServices = AuthServices();
  final ProductServices productServices = ProductServices();
  final CommandeServices commandeServices = CommandeServices();


  @override
  void initState(){
    super.initState();
  }

  Future<void> _initializeUserData() async { // Fonction d'initialisation asynchrone
    authServices.getUserData(context); // Important: await ici
    setState(() {
      _isInitialized = true; // Marquer l'initialisation comme terminée
    });
  }


   @override
  Widget build(BuildContext context) {

    if (_isInitialized) {
      return const MaterialApp( // <-- MaterialApp ici pour l'écran de chargement
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Passion Apiculture',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Provider.of<UserProvider>(context).user.token.isEmpty
          ? const LoginScreen()
          : HomeScreen(),
    );
  }
}