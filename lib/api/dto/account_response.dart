class AccountResponse {
  String message;
  String status;
  AccountData data;

  AccountResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory AccountResponse.fromJson(Map<String, dynamic> json) {
    return AccountResponse(
      message: json['message'],
      status: json['status'],
      data: AccountData.fromJson(json['data']),
    );
  }
}

class AccountData {
  int id;
  String firstName;
  String lastName;
  String gender;
  String birthday;
  String email;
  String password;
  Role role;

  AccountData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthday,
    required this.email,
    required this.password,
    required this.role,
  });

  factory AccountData.fromJson(Map<String, dynamic> json) {
    return AccountData(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      birthday: json['birthday'],
      email: json['email'],
      password: json['password'],
      role: Role.fromJson(json['role']),
    );
  }
}

class Role {
  int id;
  String type;

  Role({required this.id, required this.type});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      type: json['type'],
    );
  }
}