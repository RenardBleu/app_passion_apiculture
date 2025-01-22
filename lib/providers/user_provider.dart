import 'package:app_passion_apiculture/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
    User _user = User(
      id: '',
      nom: '',
      prenom: '', 
      email: '', 
      token: '', 
      password: '',
    );

    User get user => _user;

    void setUser(String user){
      print(user);  
      _user = User.fromJson(user);
      notifyListeners();
      print(_user.nom);
    }

    void setUserFromModel(User user){
        _user = user;
        notifyListeners();
    }
}