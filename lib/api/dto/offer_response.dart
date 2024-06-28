import 'package:servifix_flutter/api/dto/publication_response.dart';
import 'package:servifix_flutter/api/dto/state_offer_response.dart';
import 'package:servifix_flutter/api/dto/technical_response.dart';

class OfferResponse {
  int id;
  String availability;
  double amount;
  String description;
  TechnicalData technical;
  PublicationResponse publication;
  StateOffer stateOffer;

  OfferResponse({
    required this.id,
    required this.availability,
    required this.amount,
    required this.description,
    required this.technical,
    required this.publication,
    required this.stateOffer,
  });

  factory OfferResponse.fromJson(Map<String, dynamic> json) {
    return OfferResponse(
        id: json['id'],
        availability: json['availability'],
        amount: json['amount'],
        description:json['description'],
        technical: TechnicalData.fromJson(json['technical']),
        publication: PublicationResponse.fromJson(json['publication']),
        stateOffer: StateOffer.fromJson(json['stateOffer']),
    );
  }
}
