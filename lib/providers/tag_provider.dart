import 'package:app_passion_apiculture/models/tag.dart';
import 'package:flutter/material.dart';

class TagProvider extends ChangeNotifier {
  List<Tag> _tags = [];

  List<Tag> get tags => _tags;

  void setTags(String jsonResponse) {
    _tags = Tag.fromJson(jsonResponse);
    notifyListeners();
  }

  void addTag(Tag tag) {
    _tags.add(tag);
    notifyListeners();
  }

  void removeTag(int id) {
    _tags.removeWhere((tag) => tag.id == id);
    notifyListeners();
  }

  void updateTag(Tag updatedTag) {
    final index = _tags.indexWhere((tag) => tag.id == updatedTag.id);
    if (index != -1) {
      _tags[index] = updatedTag;
      notifyListeners();
    }
  }
}