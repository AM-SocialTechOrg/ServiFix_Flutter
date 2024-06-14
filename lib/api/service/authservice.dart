import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dto/login_request.dart';
import '../dto/login_response.dart';
import '../dto/register_request.dart';
import '../dto/register_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      await _saveUserData(loginResponse.token, loginResponse.id);
      return loginResponse;
    } else {
      final res = json.decode(response.body);
      final errorMessage = res['message'] ?? 'Failed to load response';
      throw Exception(errorMessage);
    }
  }

  Future<void> _saveUserData(String token, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setInt('userId', id);
  }

  Future<RegisterResponse> register(String firstName, String lastName, String gender, String birthday, String email, String password, int role) async {
    final requestBody = RegisterRequest(
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      birthday: birthday,
      email: email,
      password: password,
      role: role,
    ).toJson();
    final bodyJson = json.encode(requestBody);

    final response = await http.post(
      Uri.parse(apiBase + "auth/register"),
      headers: {
        'Content-Type': 'application/json',
      },
      encoding: Encoding.getByName('utf-8'),
      body: bodyJson,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final res = json.decode(response.body);
      final registerResponse = RegisterResponse.fromJson(res);
      return registerResponse;
    } else {
      print(response.body);
      final res = json.decode(response.body);
      final errorMessage = res['message'] ?? 'Failed to load response';
      throw Exception(errorMessage);
    }
  }
}
