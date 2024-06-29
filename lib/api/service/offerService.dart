import 'package:http/http.dart' as http;
import 'package:servifix_flutter/api/dto/offer_request.dart';
import 'package:servifix_flutter/api/dto/offer_response.dart';
import 'dart:convert';
import './config.dart';

class OfferService {
  static const String apiBase = Config.apiBase;

  Future<OfferResponse> createOffer(String token, OfferRequest offer) async {
    final requestBody = offer.toJson();
    final bodyJson = json.encode(requestBody);

    print("bodyJson: " + bodyJson);

    final response = await http.post(
      Uri.parse(apiBase + "servifix/offers"),
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
        return OfferResponse.fromJson(res['data']);
      } else {
        throw Exception('The response does not contain a "data" field');
      }
    } else {
      throw Exception('Failed to load backend: ${response.statusCode}');
    }
  }

  Future<List<OfferResponse2>> getOffersByTechnicalId(String token, int technicalId) async {
    final response = await http.get(
      Uri.parse(apiBase + "servifix/offers/technical/$technicalId"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(utf8.decode(response.bodyBytes));
      print("respuesta json:" + responseData.toString());

      if (responseData['data'] != null) {
        List<dynamic> data = responseData['data'];
        List<OfferResponse2> offers = data.map((offerJson) => OfferResponse2.fromJson(offerJson)).toList();
        print("Ofertas obtenidas: $offers");
        return offers;
      } else {
        throw Exception('La respuesta no contiene un campo "data" válido');
      }
    } else {
      throw Exception('Error en la carga del backend: ${response.statusCode}');
    }
  }

  //editar oferta
  Future<void> updateOffer(String token, OfferRequest offer, String offerId) async {
    final requestBody = offer.toJson();
    final bodyJson = json.encode(requestBody);
    final response = await http.put(
      Uri.parse(apiBase + "servifix/offers/" + offerId),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      encoding: Encoding.getByName('utf-8'),
      body: bodyJson,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to edit publication');
    }
  }
}