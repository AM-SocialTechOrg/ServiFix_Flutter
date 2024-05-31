import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dto/login_request.dart';
import '../dto/login_response.dart';

class AuthService {
  static const String apiBase = "https://servifix-api-docker.onrender.com/api/v1/";

  Future<LoginResponse> login(String email, String password) async {
    final requestBody = LoginRequest(email: email, password: password).toJson();
    final bodyJson = json.encode(requestBody);

    final response = await http.post(
      Uri.parse(apiBase + "auth/login"),
      headers: {
        'Content-Type': 'application/json',
      },
      encoding: Encoding.getByName('utf-8'),
      body: bodyJson,
    );

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final loginResponse = LoginResponse.fromJson(res);
      return loginResponse;
    } else {
      throw Exception('Failed to load response: ${response.statusCode}');
    }
  }


}