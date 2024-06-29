class PaymentResponse {
  final int id;
  final String type;
  final double amount;
  final String cardNumber;
  final int offerId;

  PaymentResponse({
    required this.id,
    required this.type,
    required this.amount,
    required this.cardNumber,
    required this.offerId,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      id: json['id'],
      type: json['type'],
      amount: json['amount'],
      cardNumber: json['cardNumber'],
      offerId: json['offerId'],
    );
  }
}