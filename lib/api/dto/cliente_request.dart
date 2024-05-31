
class ClienteRequest {
  final String email;
  final String password;

  ClienteRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}