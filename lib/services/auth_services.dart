import 'package:flutter/material.dart';
import 'package:app_passion_apiculture/models/user.dart';
import 'package:app_passion_apiculture/utils/constants.dart';
import 'package:app_passion_apiculture/utils/utils.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  void signUpUser({
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
}