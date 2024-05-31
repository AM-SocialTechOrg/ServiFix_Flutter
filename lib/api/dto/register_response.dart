class RegisterResponse {
  final String message;
  final String status;
  final RegisterData data;

  RegisterResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  static RegisterResponse fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'] as String,
      status: json['status'] as String,
      data: RegisterData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class RegisterData {
  final int id;
  final String firstName;
  final String lastName;
  final String gender;
  final String birthday;
  final String email;
  final String password;
  final Role role;

  RegisterData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthday,
    required this.email,
    required this.password,
    required this.role,
  });

  static RegisterData fromJson(Map<String, dynamic> json) {
    return RegisterData(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      gender: json['gender'] as String,
      birthday: json['birthday'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: Role.fromJson(json['role'] as Map<String, dynamic>),
    );
  }
}

class Role {
  final int id;
  final String type;

  Role({
    required this.id,
    required this.type,
  });

  static Role fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'] as int,
      type: json['type'] as String,
    );
  }
}