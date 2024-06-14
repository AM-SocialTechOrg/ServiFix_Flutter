class UserRequest {
  final String address;
  final String description;
  final String image;
  final String number;
  final int accountId;

  UserRequest({
    required this.address,
    required this.description,
    required this.image,
    required this.number,
    required this.accountId,
  });

  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "description": description,
      "image": image,
      "number": number,
      "account": accountId,
    };
  }
}