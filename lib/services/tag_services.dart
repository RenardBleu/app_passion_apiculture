import 'dart:convert';

import 'package:app_passion_apiculture/models/tag.dart';
import 'package:app_passion_apiculture/providers/tag_provider.dart';
import 'package:app_passion_apiculture/utils/constants.dart';
import 'package:app_passion_apiculture/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TagServices {
  Future<List<Tag>> getTag({
    required BuildContext context,
    required String token,
  }) async {
    try {
      var tagProvider = Provider.of<TagProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/tag'),
        body: jsonEncode({
          'token': token,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      List<Tag> tags = []; // Initialiser une liste vide

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          print("=======================");
          tagProvider.setTags(res.body);
          tags = tagProvider.tags;
          print("Tags récupérés : ${tags.length}");
        },
      );

      return tags; // Retourne les tags (même s'il est vide)
    } catch (e) {
      showSnackBar(context, e.toString());
      return []; // Retourne une liste vide en cas d'erreur
    }
  }
}
