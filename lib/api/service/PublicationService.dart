import 'package:http/http.dart' as http;
import 'package:servifix_flutter/api/dto/publication_request.dart';
import 'dart:convert';
//import '../model/publication.dart';
import 'package:servifix_flutter/api/dto/publication_response.dart';
import './config.dart';

class PublicationService {

  static const String apiBase = Config.apiBase;
/*
* /api/v1/servifix/publications/user/{id}
Get all publications by user

Parameters
* */
  Future<List<PublicationResponse> > getPublications(String id,String TokenModel) async {
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
        List<PublicationResponse> publicationResponse = (res['data'] as List).map((i) => PublicationResponse.fromJson(i)).toList();
        print( "respuesta json res:" + publicationResponse[0].description.toString());
        return publicationResponse;
      } else {
        throw Exception('The response does not contain a "data" field');
      }
    } else {
      throw Exception('Failed to load backend: ${response.statusCode}');
    }
  }

  Future<List<PublicationResponse>> getAllPublications(String TokenModel) async {
    String token = TokenModel;

    final response = await http.get(
      Uri.parse(apiBase + "servifix/publications"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Incluye el token de autenticación en el encabezado
      },
    );
    if (response.statusCode == 200) {
      final res = json.decode(utf8.decode(response.bodyBytes));
      print( "respuesta json:" + res.toString());

      if (res['data'] != null) {
        List<PublicationResponse> publicationResponse = (res['data'] as List).map((i) => PublicationResponse.fromJson(i)).toList();
        return publicationResponse;
      } else {
        throw Exception('The response does not contain a "data" field');
      }
    } else {
      throw Exception('Failed to load backend: ${response.statusCode}');
    }
  }

  Future<PublicationResponse> getPublicationById(String id,String TokenModel) async {
    String token = TokenModel;

    final response = await http.get(
      Uri.parse(apiBase + "servifix/publications/$id"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Incluye el token de autenticación en el encabezado
      },
    );
    if (response.statusCode == 200) {
      final res = json.decode(utf8.decode(response.bodyBytes));
      print( "respuesta json:" + res.toString());

      if (res['data'] != null) {
        return PublicationResponse.fromJson(res['data']);
      } else {
        throw Exception('The response does not contain a "data" field');
      }
    } else {
      throw Exception('Failed to load backend: ${response.statusCode}');
    }
  }

  Future<PublicationResponse> createPublication(String token, PublicationRequest publication) async{
    final bodyJson =  json.encode(publication.toJson());
    print(token);
    print(bodyJson);

    final response = await http.post(
      Uri.parse(apiBase + "servifix/publications"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: bodyJson,
    );

    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      final res = json.decode(response.body);
      final publicationResponse = PublicationResponse.fromJson(res);
      return publicationResponse;
    } else {
      throw Exception('Failed to create Publication: ${response.statusCode}');
    }
  }

  Future<void> editPublication(String publicationId, String token, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse(apiBase + "servifix/publications/$publicationId"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to edit publication');
    }
  }

  Future<void> deletePublication(String publicationId, String token) async {
    final response = await http.delete(
      Uri.parse(apiBase + "servifix/publications/$publicationId"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete publication');
    }
  }
}
