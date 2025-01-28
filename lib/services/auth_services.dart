import 'package:app_passion_apiculture/providers/user_provider.dart';
import 'package:app_passion_apiculture/screens/home_screen.dart';
import 'package:app_passion_apiculture/screens/login_screen.dart';
import 'package:app_passion_apiculture/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_passion_apiculture/utils/utils.dart';
import 'package:app_passion_apiculture/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class AuthServices {

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
    required String nom,
    required String prenom,
    required String createAt,
  }) async {
    try{
      User user = User(
        id: '',
        nom: nom, 
        prenom: prenom, 
        email: email, 
        token: '', 
        password: password,
        createAt: createAt
      );
      print(user.email);
      print(user.nom);
      print(user.prenom);
      print(user.password);

      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: (){
          showSnackBar(
            context, 'Compte crée avec succé ! Connect toi avec les mêmes identifiants'
          );
        }
      );
    }catch(e){
      showSnackBar(context, e.toString());
    }
  }


  void LoginUser({
    required BuildContext context,
    required String email,
    required String password,
  })
  async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
         headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async{
          SharedPreferences pref = await SharedPreferences.getInstance();
          userProvider.setUser(res.body);
          await pref.setString('x-auth-token', jsonDecode(res.body)['token']);
          print(userProvider.user.email);
          navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
            (route) => false,
          );
        },
      );
    }catch(e){
      showSnackBar(context, e.toString());
    }
  }


  // get user data

  void getUserData(
    BuildContext context,
  ) async{
    try{
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('x-auth-token');

    if(token == null){
      pref.setString('x-auth-token', '');
    }

    var tokenRes = await http.post(
      Uri.parse('${Constants.uri}/tokenIsValid'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!,
      },
    );

    var response = jsonDecode(tokenRes.body);

    if(response == true){
      http.Response userRes = await http.get(
        Uri.parse('${Constants.uri}/'),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8','x-auth-token': token}
      );

      userProvider.setUser(userRes.body);
    }

    }catch(e){
      showSnackBar(context, e.toString());
    }
  }


  void signOut(BuildContext context) async{
    final navigator = Navigator.of(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('x-auth-token', '');
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context)=> const LoginScreen()
        ),
         (route) => false,
    );
  }
}