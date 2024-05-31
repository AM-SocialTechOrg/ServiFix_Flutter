import 'package:http/http.dart' as http;
import 'dart:convert';
import '../dto/cliente_response.dart';
import '../provider/AuthModel.dart';

class ClienteService {

  static const String apiBase = "https://servifix-api-docker.onrender.com/api/v1/";

  Future<ClienteResponse> getCliente(String id,String TokenModel) async {
    String token = TokenModel;

    final response = await http.get(
      Uri.parse(apiBase + "servifix/users/$id"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Incluye el token de autenticación en el encabezado
      },
    );

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      print( "respuesta json:" + res.toString());
      final clienteResponse = ClienteResponse.fromJson(res);
      return clienteResponse;
    } else {
      throw Exception('Failed to load backend: ${response.statusCode}');
    }
  }



}
