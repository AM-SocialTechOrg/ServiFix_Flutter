import 'package:http/http.dart' as http;
import 'package:servifix_flutter/api/dto/get_technical_response_by_account.dart';
import 'dart:convert';
import '../dto/technical_request.dart';
import '../dto/technical_response.dart';

class TechnicalService {
  static const String apiBase = "https://servifix-api-docker.onrender.com/api/v1/";

  Future<GetTechnicalResponseByAccount> getTechnicianByAccountId(int id,String TokenModel) async {
    String token = TokenModel;

    final response = await http.get(
      Uri.parse(apiBase + "servifix/technicals/account/$id"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('Response: ' + response.body);

    if (response.statusCode == 200) {
      final res = json.decode(utf8.decode(response.bodyBytes));
      print( "respuesta json:" + res.toString());
      final clienteResponse = GetTechnicalResponseByAccount.fromJson(res);
      return clienteResponse;
    } else {
      throw Exception('Failed to load backend: ${response.statusCode}');
    }
  }


  Future<TechnicalResponse> createTechnical(TechnicalRequest request, String token) async {
    final bodyJson = json.encode(request.toJson());

    print ('Json: ' + bodyJson);

    final response = await http.post(
      Uri.parse(apiBase + "servifix/technicals"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: bodyJson,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final res = json.decode(response.body);
      final technicalResponse = TechnicalResponse.fromJson(res);
      return technicalResponse;
    } else {
      throw Exception('Failed to create Technical: ${response.statusCode}');
    }
  }
}
