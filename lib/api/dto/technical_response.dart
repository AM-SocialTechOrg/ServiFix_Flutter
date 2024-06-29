import 'package:servifix_flutter/api/dto/cliente_response.dart';

class TechnicalResponse {
  final String message;
  final String status;
  final TechnicalData data;

  TechnicalResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory TechnicalResponse.fromJson(Map<String, dynamic> json) {
    return TechnicalResponse(
      message: json['message'],
      status: json['status'],
      data: TechnicalData.fromJson(json['data']),
    );
  }
}

class TechnicalData {
  final int technicalId;
  final String policeRecords;
  final String skills;
  final String experience;
  final String number;
  final String description;
  final Account account;

  TechnicalData({
    required this.technicalId,
    required this.policeRecords,
    required this.skills,
    required this.experience,
    required this.number,
    required this.description,
    required this.account,
  });

  factory TechnicalData.fromJson(Map<String, dynamic> json) {
    return TechnicalData(
      technicalId: json['technicalId'],
      policeRecords: json['policeRecords'],
      skills: json['skills'],
      experience: json['experience'],
      number: json['number'],
      description: json['description'],
      account: Account.fromJson(json['account']),
    );
  }
}



class TechnicalResponse2 {
  final int id;
  final String policeRecords;
  final String skills;
  final String experience;
  final String number;
  final String description;
  final Account account;

  TechnicalResponse2({
    required this.id,
    required this.policeRecords,
    required this.skills,
    required this.experience,
    required this.number,
    required this.description,
    required this.account,
  });

  factory TechnicalResponse2.fromJson(Map<String, dynamic> json) {
    return TechnicalResponse2(
      id: json['id'],
      policeRecords: json['policeRecords'],
      skills: json['skills'],
      experience: json['experience'],
      number: json['number'],
      description: json['description'],
      account: Account.fromJson(json['account']),
    );
  }
}

