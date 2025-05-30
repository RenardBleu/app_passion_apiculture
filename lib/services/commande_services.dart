import 'dart:convert';

import 'package:app_passion_apiculture/models/commande.dart';
import 'package:app_passion_apiculture/models/commande_product.dart';
import 'package:app_passion_apiculture/providers/commande_provider.dart';
import 'package:app_passion_apiculture/utils/constants.dart';
import 'package:app_passion_apiculture/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CommandeServices {
  Future<List<Commande>> getCommande({
    required BuildContext context,
    required String token,
  }) async {
    try {
      var commandeProvider = Provider.of<CommandeProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/commande'),
        body: jsonEncode({
          'token': token,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      List<Commande> commandes = []; // Initialiser une liste vide

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          print("=======================");
          commandeProvider.setCommandes(res.body);
          commandes = commandeProvider.commandes;
          print("Commandes récupérés : ${commandes.length}");
        },
      );

      return commandes; // Retourne les types (même s'il est vide)
    } catch (e) {
      showSnackBar(context, e.toString());
      return []; // Retourne une liste vide en cas d'erreur
    }
  }
}

class CommandeProductServices {
  Future<List<CommandeProduct>> getCommandeProducts({
    required BuildContext context,
    required String token,
    required String commandeNum,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/commande/products'),
        body: jsonEncode({
          'token': token,
          'idCommande': commandeNum,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      List<CommandeProduct> products = [];

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          products = CommandeProduct.fromJson(res.body);
          print("=======================");
          print("Commandes récupérés : ${products.length}");
        },
      );

      return products;
    } catch (e) {
      showSnackBar(context, e.toString());
      return [];
    }
  }
}
