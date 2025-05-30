import 'package:app_passion_apiculture/models/type.dart';
import 'package:flutter/material.dart';

class TypeProvider extends ChangeNotifier {
  List<Type> _types = [];

  List<Type> get types => _types;

  void setTypes(String jsonResponse) {
    _types = Type.fromJson(jsonResponse);
    notifyListeners();
  }

  void addType(Type type) {
    _types.add(type);
    notifyListeners();
  }

  void removeType(int id) {
    _types.removeWhere((type) => type.id == id);
    notifyListeners();
  }

  void updateType(Type updatedType) {
    final index = _types.indexWhere((type) => type.id == updatedType.id);
    if (index != -1) {
      _types[index] = updatedType;
      notifyListeners();
    }
  }
}