import 'package:servifix_flutter/api/dto/cliente_response.dart';

class UserResponse {
  final String message;
  final String status;
  final UserData data;

  UserResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      message: json['message'],
      status: json['status'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final int id;
  final String address;
  final String description;
  final String image;
  final String number;
  final Account account;

  UserData({
    required this.id,
    required this.address,
    required this.description,
    required this.image,
    required this.number,
    required this.account,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      address: json['address'],
      description: json['description'],
      image: json['image'],
      number: json['number'],
      account: Account.fromJson(json['account']),
    );
  }
}