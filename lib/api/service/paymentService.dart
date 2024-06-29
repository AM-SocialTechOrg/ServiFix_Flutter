import 'package:http/http.dart' as http;
import 'package:servifix_flutter/api/dto/payment_request.dart';
import 'package:servifix_flutter/api/dto/payment_response.dart';
import 'dart:convert';
import './config.dart';

class PaymentService {
  static const String apiBase = Config.apiBase;

  Future<PaymentResponse> createPayment(String token, PaymentRequest payment) async {
    final requestBody = payment.toJson();
    final bodyJson = json.encode(requestBody);

    print("bodyJson: " + bodyJson);

    final response = await http.post(
      Uri.parse(apiBase + "servifix/payments"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      encoding: Encoding.getByName('utf-8'),
      body: bodyJson,
    );

    print(response.body);

    if (response.statusCode == 200) {
      final res = json.decode(utf8.decode(response.bodyBytes));
      print("respuesta json:" + res.toString());

      if (res['data'] != null) {
        return PaymentResponse.fromJson(res['data']);
      } else {
        throw Exception('The response does not contain a "data" field');
      }
    } else {
      throw Exception('Failed to load backend: ${response.statusCode}');
    }
  }
}