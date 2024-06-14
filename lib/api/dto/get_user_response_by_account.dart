import 'package:servifix_flutter/api/dto/cliente_response.dart';

class GetUserResponseByAccount {
  final int id;
  final String address;
  final String description;
  final String image;
  final String number;
  final Account account;

  GetUserResponseByAccount({
    required this.id,
    required this.address,
    required this.description,
    required this.image,
    required this.number,
    required this.account,
  });

  factory GetUserResponseByAccount.fromJson(Map<String, dynamic> json) {
    return GetUserResponseByAccount(
      id: json['data']['id'],
      address: json['data']['address'],
      description: json['data']['description'],
      image: json['data']['image'],
      number: json['data']['number'],
      account: Account.fromJson(json['data']['account']),
    );
  }
}