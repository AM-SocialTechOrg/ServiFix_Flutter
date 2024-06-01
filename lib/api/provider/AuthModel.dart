import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Authmodel  extends ChangeNotifier {
  //login user
  String token = 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJKaG9uYXRhbkBnbWFpbC5jb20iLCJpYXQiOjE3MTcxODgxODAsImV4cCI6MTcxOTc4MDE4MCwicm9sZXMiOltdfQ.qP-R2ngkZo0j0EsTrZfclDyPxKY35Q1MW5Fr9W2-i38';
  String id = '3';
  String get getToken => token;
  String get getId => id;
  void setToken(String token) {
    this.token = token;
    print('Token authmodel: $token');
    notifyListeners();
  }
  void setId(String id) {
    this.id = id;
    print('Id authmodel: $id');
    notifyListeners();
  }
}


