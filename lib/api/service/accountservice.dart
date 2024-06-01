import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dto/account_request.dart';
import '../dto/account_response.dart';

class AccountService {
  static const String apiBase = "https://servifix-api-docker.onrender.com/api/v1/";

  Future<AccountResponse> createAccount(String firstName, String lastName, String gender, String birthday, String email, String password, int role) async {
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
