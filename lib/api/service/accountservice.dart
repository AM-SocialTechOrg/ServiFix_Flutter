import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dto/account_request.dart';
import '../dto/account_response.dart';
import './config.dart';

class AccountService {
  static const String apiBase = Config.apiBase;

  Future<AccountResponse> createAccount(
      String firstName,
      String lastName,
      String gender,
      String birthday,
      String email,
      String password,
      int role,
      String token
      ) async {
    final requestBody = AccountRequest(
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      birthday: birthday,
      email: email,
      password: password,
      role: role,
    ).toJson();
    final bodyJson = json.encode(requestBody);

    print(bodyJson);

    final response = await http.post(
      Uri.parse(apiBase + "servifix/accounts"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: bodyJson,
    );

    print(bodyJson);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);

      final res = json.decode(response.body);
      final accountResponse = AccountResponse.fromJson(res);
      return accountResponse;
    } else {
      print(response.body);

      throw Exception('Failed to register account: ${response.statusCode}');
    }
  }
}
