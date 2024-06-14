class LoginResponse {
  final String message;
  final String status;
  final Map<String, dynamic> data;
  final String token;
  final int id;

  LoginResponse({
    required this.message,
    required this.status,
    required this.data,
    required this.token,
    required this.id,
  });

  static LoginResponse fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] as String,
      status: json['status'] as String,
      data: json['data'] as Map<String, dynamic>,
      token: json['data']['token'] as String,
      id: json['data']['id'] as int,
    );
  }
}