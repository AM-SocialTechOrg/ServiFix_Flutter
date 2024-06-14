import 'package:servifix_flutter/api/dto/cliente_response.dart';

class GetTechnicalResponseByAccount {
  final int technicalId;
  final String policeRecords;
  final String skills;
  final String experience;
  final String number;
  final String description;
  final Account account;

  GetTechnicalResponseByAccount({
    required this.technicalId,
    required this.policeRecords,
    required this.skills,
    required this.experience,
    required this.number,
    required this.description,
    required this.account,
  });

  factory GetTechnicalResponseByAccount.fromJson(Map<String, dynamic> json) {
    return GetTechnicalResponseByAccount(
      technicalId: json['data']['technicalId'],
      policeRecords: json['data']['policeRecords'],
      skills: json['data']['skills'],
      experience: json['data']['experience'],
      number: json['data']['number'],
      description: json['data']['description'],
      account: Account.fromJson(json['data']['account']),
    );
  }
}