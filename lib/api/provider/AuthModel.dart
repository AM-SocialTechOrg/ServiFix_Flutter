import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Authmodel  extends ChangeNotifier {
  //login user
  String token = '';
  String get getToken => token;
  void setToken(String token) {
    this.token = token;
    print('Token authmodel: $token');
    notifyListeners();
  }
}


