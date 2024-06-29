import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Authmodel  extends ChangeNotifier {
  //login user
  String token = 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJKaG9uYXRhbkBnbWFpbC5jb20iLCJpYXQiOjE3MTcxODgxODAsImV4cCI6MTcxOTc4MDE4MCwicm9sZXMiOltdfQ.qP-R2ngkZo0j0EsTrZfclDyPxKY35Q1MW5Fr9W2-i38';
  String id = '3';
  String publicId = '3';
  String get getToken => token;
  String get getId => id;
  String get getPublicId => publicId;
  void setToken(String token) {
    this.token = token;
    notifyListeners();
  }
  void setId(String id) {
    this.id = id;
    print('Id authmodel: $id');
    notifyListeners();
  }
  void setPublicId(String publicId) {
    this.publicId = publicId;
    print("PublicId asignado: $publicId");
    notifyListeners();
  }

}


