import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/publication.dart';

class PublicationService {

  static const String apiBase = "https://servifix-api-docker.onrender.com/api/v1/";
/*
* /api/v1/servifix/publications/user/{id}
Get all publications by user

Parameters
* */
  Future<List<Publicaticion> > getPublications(String id,String TokenModel) async {
    String token = TokenModel;

    final response = await http.get(
      Uri.parse(apiBase + "servifix/publications/user/$id"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Incluye el token de autenticación en el encabezado
      },
    );
    if (response.statusCode == 200) {
      final res = json.decode(utf8.decode(response.bodyBytes));
      print( "respuesta json:" + res.toString());

      if (res['data'] != null) {
        List<Publicaticion> publicationResponse = (res['data'] as List).map((i) => Publicaticion.fromJson(i)).toList();
        return publicationResponse;
      } else {
        throw Exception('The response does not contain a "data" field');
      }
    } else {
      throw Exception('Failed to load backend: ${response.statusCode}');
    }
  }
}
