import 'package:flutter/cupertino.dart';
import 'package:servifix_flutter/api/dto/cliente_response.dart';
import 'package:servifix_flutter/api/dto/offer_response.dart';

class NotificationResponse {
  int id;
  String title;
  String content;
  String date;
  //Account account;
  //OfferResponse offer;

  NotificationResponse({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    //required this.account,
    //required this.offer,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      date: json['date'] as String,
      //account: Account.fromJson(json['account']),
      //offer: OfferResponse.fromJson(json['offer']),
    );
  }
}
