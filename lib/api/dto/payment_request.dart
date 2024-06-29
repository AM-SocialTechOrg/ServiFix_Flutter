class PaymentRequest {
  final String type;
  final double amount;
  final String cardNumber;
  final int offerId;

  PaymentRequest({
    required this.type,
    required this.amount,
    required this.cardNumber,
    required this.offerId,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'amount': amount,
      'cardNumber': cardNumber,
      'offerId': offerId,
    };
  }
}