class OfferRequest {
  final String availability;
  final double amount;
  final String description;
  final int technical;
  final int publication;
  final int stateOffer;

  OfferRequest({
    required this.availability,
    required this.amount,
    required this.description,
    required this.technical,
    required this.publication,
    required this.stateOffer,
  });

  Map<String, dynamic> toJson() {
    return {
      'availability': availability,
      'amount': amount,
      'description': description,
      'technical': technical,
      'publication': publication,
      'stateOffer': stateOffer,
    };
  }
}
