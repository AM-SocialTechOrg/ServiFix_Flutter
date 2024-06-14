import 'package:servifix_flutter/api/dto/user_response.dart';

class PublicationResponse {
  final int id;
  final String title;
  final String description;
  final double amount;
  final String picture;
  final String address;
  final UserData user;
  final Job job;

  PublicationResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.picture,
    required this.address,
    required this.user,
    required this.job,
  });

  factory PublicationResponse.fromJson(Map<String, dynamic> json) {
    return PublicationResponse(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      amount: json['amount'].toDouble(),
      picture: json['picture'],
      address: json['address'],
      user: UserData.fromJson(json['user']),
      job: Job.fromJson(json['job']),
    );
  }
}

class Job {
  final int id;
  final String name;
  final String description;

  Job({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}