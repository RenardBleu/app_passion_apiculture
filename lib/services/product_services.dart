import 'dart:convert';

import 'package:app_passion_apiculture/providers/product_provider.dart';
import 'package:app_passion_apiculture/utils/constants.dart';
import 'package:app_passion_apiculture/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductServices {
  void getProduct({
    required BuildContext context,
    required String token,
  })
  async {
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
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async{
          productProvider.setProducts(res.body);
          print("------------");
          print(productProvider.products[1].title);
        },
      );
    }catch(e){
      showSnackBar(context, e.toString());
    }
  }
}