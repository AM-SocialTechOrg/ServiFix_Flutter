import 'package:http/http.dart' as http;

import 'package:servifix_flutter/api/dto/notification_response.dart';
import 'dart:convert';
import './config.dart';

class Notificationservice {
  static const String apiBase = Config.apiBase;

  // solicitar notificaciones por id de cuenta
  Future<List<NotificationResponse>> getNotificationByAccountId(int id,String TokenModel) async {
    String token = TokenModel;

    final response = await http.get(
      Uri.parse(apiBase + "servifix/notifications/account/$id"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('Response notificaciones: ' + response.body);

    if (response.statusCode == 200) {
      final res = json.decode(utf8.decode(response.bodyBytes));
      print( "respuesta json:" + res.toString());
      final notificationList = res['data'] as List;
      final notificationResponse = notificationList.map((e) => NotificationResponse.fromJson(e)).toList();
      print("notificaciones: " + notificationResponse.toString());
      return notificationResponse;
    } else {
      throw Exception('Failed to load backend: ${response.statusCode}');
    }
  }

}