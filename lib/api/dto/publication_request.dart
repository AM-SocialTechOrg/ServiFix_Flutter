class PublicationRequest {
  final String title;
  final String description;
  final double amount;
  final String picture;
  final String address;
  final int user;
  final int job;

  PublicationRequest({
    required this.title,
    required this.description,
    required this.amount,
    required this.picture,
    required this.address,
    required this.user,
    required this.job,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'amount': amount,
      'picture': picture,
      'address': address,
      'user': user,
      'job': job,
    };
  }
}
