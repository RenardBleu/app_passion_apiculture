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
      createAt: '',
    );

    User get user => _user;

    void setUser(String user){
      _user = User.fromJson(user);
      notifyListeners();
    }

    void setUserFromModel(User user){
        _user = user;
        notifyListeners();
    }
}