import 'dart:convert';
import 'dart:ffi';

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

  Future<bool> updateStock({
    required BuildContext context,
    required String token,
    required String productId,
    required int stock,
  }) async {
    try {

      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/product/update-stock'),
        body: jsonEncode({
          'token': token,
          'id': productId,
          'stock': stock,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          print("=======================");
          print("Produits récupérés : ${res.body}");
        },
      );

      return true; // Retourne les produits (même s'il est vide)
    } catch (e) {
      showSnackBar(context, e.toString());
      return false;
    }
  }

  Future<bool> editProduct({
    required BuildContext context,
    required String token,
    required Product product,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/product/update'),
        body: jsonEncode({
          'token': token,
          'id': int.parse(product.id),
          'title': product.title,
          'description': product.descrip,
          'prix': double.parse(product.prix),
          'idType': int.parse(product.type),
          'miniature': product.minia,
          'caracteristiques': product.caracteristique,
          'stock': product.stock
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      bool success = false;

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final data = json.decode(res.body);
          success = data['success'] == true;
        },
      );

      return success;
    } catch (e) {
      showSnackBar(context, e.toString());
      return false;
    }
  }

  Future<bool> addProduct({
    required BuildContext context,
    required String token,
    required Product product,
  }) async {
    try {
      var productProvider = Provider.of<ProductProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/product/create'),
        body: jsonEncode({
          'token': token,
          'title': product.title,
          'description': product.descrip,
          'prix': double.parse(product.prix),
          'idType': int.parse(product.type),
          'caracteristiques': product.caracteristique,
          'stock': product.stock
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      bool success = false;


      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final data = json.decode(res.body);
          final newProduct = Product.fromMap(data);
          productProvider.addProduct(newProduct);
          success = true;
        },
      );

      return success;
    } catch (e) {
      showSnackBar(context, e.toString());
      return false;
    }
  }
}