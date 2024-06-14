import 'package:http/http.dart' as http;
import 'package:servifix_flutter/api/dto/get_user_response_by_account.dart';
import 'package:servifix_flutter/api/dto/user_request.dart';
import 'package:servifix_flutter/api/dto/user_response.dart';
import 'dart:convert';
import '../dto/cliente_response.dart';
import '../provider/AuthModel.dart';

class ClientService {

  static const String apiBase = "https://servifix-api-docker.onrender.com/api/v1/";

  Future<ClienteResponse> getCliente(String id,String TokenModel) async {
    String token = TokenModel;

    final response = await http.get(
      Uri.parse(apiBase + "servifix/users/$id"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('Response: ' + response.body);

    if (response.statusCode == 200) {
      final res = json.decode(utf8.decode(response.bodyBytes));
      print( "respuesta json:" + res.toString());
      final clienteResponse = ClienteResponse.fromJson(res);
      return clienteResponse;
    } else {
      throw Exception('Failed to load backend: ${response.statusCode}');
    }
  }

  Future<GetUserResponseByAccount> getUserByAccountId(int id,String TokenModel) async {
    String token = TokenModel;

    final response = await http.get(
      Uri.parse(apiBase + "servifix/users/account/$id"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('Response: ' + response.body);

    if (response.statusCode == 200) {
      final res = json.decode(utf8.decode(response.bodyBytes));
      print( "respuesta json:" + res.toString());
      final clienteResponse = GetUserResponseByAccount.fromJson(res);
      return clienteResponse;
    } else {
      throw Exception('Failed to load backend: ${response.statusCode}');
    }
  }

  Future<UserResponse> createUser(UserRequest request, String token) async {
    final bodyJson = json.encode(request.toJson());

    final response = await http.post(
      Uri.parse(apiBase + "servifix/users"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: bodyJson,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final res = json.decode(response.body);
      final userResponse = UserResponse.fromJson(res);
      return userResponse;
    } else {
      throw Exception('Failed to create User: ${response.statusCode}');
    }
  }

}
