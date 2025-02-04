import 'dart:convert';

import 'package:app_passion_apiculture/models/product.dart';
import 'package:app_passion_apiculture/providers/product_provider.dart';
import 'package:app_passion_apiculture/utils/constants.dart';
import 'package:app_passion_apiculture/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductServices {
  Future<List<Product>> getProduct({
    required BuildContext context,
    required String token,
  }) async {
    try {
      var productProvider = Provider.of<ProductProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/product'),
        body: jsonEncode({
          'token': token,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      List<Product> products = []; // Initialiser une liste vide

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          print("=======================");
          productProvider.setProducts(res.body);
          products = productProvider.products;
          print("Produits récupérés : ${products.length}");
        },
      );

      return products; // Retourne les produits (même s'il est vide)
    } catch (e) {
      showSnackBar(context, e.toString());
      return []; // Retourne une liste vide en cas d'erreur
    }
  }
}
