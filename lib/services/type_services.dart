import 'dart:convert';

import 'package:app_passion_apiculture/models/type.dart';
import 'package:app_passion_apiculture/providers/type_provider.dart';
import 'package:app_passion_apiculture/utils/constants.dart';
import 'package:app_passion_apiculture/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TypeServices {
  Future<List<Type>> getType({
    required BuildContext context,
    required String token,
  }) async {
    try {
      var typeProvider = Provider.of<TypeProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/type'),
        body: jsonEncode({
          'token': token,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      List<Type> types = []; // Initialiser une liste vide

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          print("=======================");
          typeProvider.setTypes(res.body);
          types = typeProvider.types;
          print("Types récupérés : ${types.length}");
        },
      );

      return types; // Retourne les types (même s'il est vide)
    } catch (e) {
      showSnackBar(context, e.toString());
      return []; // Retourne une liste vide en cas d'erreur
    }
  }
}
