import 'package:app_passion_apiculture/providers/user_provider.dart';
import 'package:app_passion_apiculture/screens/basic_screen.dart';
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
  }) async {
    try{
      User user = User(
        id: '',
        nom: nom, 
        prenom: prenom, 
        email: email, 
        token: '', 
        password: password
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
      print('-------TESTEE-------');
          print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async{
          SharedPreferences pref = await SharedPreferences.getInstance();
          print("cdzjkcijzdpocjz");
          userProvider.setUser(res.body);
          print("cdzjkcijzdpocjz");
          await pref.setString('x-auth-token', jsonDecode(res.body)['token']);
          /*navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const BasicTestScreen(),
            ),
            (route) => false,
          );*/
        },
      );
      print('-------TEST-------');
      print(userProvider.user.email);
    }catch(e){
      showSnackBar(context, e.toString());
    }
  }
}