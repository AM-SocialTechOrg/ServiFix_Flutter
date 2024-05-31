class Role {
  final int id;
  final String type;

  Role({
    required this.id,
    required this.type,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'] as int,
      type: json['type'] as String,
    );
  }
}

class Account {
  final int id;
  final String firstName;
  final String lastName;
  final String gender;
  final String birthday;
  final String email;
  final String password;
  final Role role;

  Account({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthday,
    required this.email,
    required this.password,
    required this.role,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      gender: json['gender'] as String,
      birthday: json['birthday'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: Role.fromJson(json['role']),
    );
  }
}

class ClienteData {
  final int id;
  final String address;
  final String description;
  final String image;
  final String number;
  final Account account;

  ClienteData({
    required this.id,
    required this.address,
    required this.description,
    required this.image,
    required this.number,
    required this.account,
  });

  factory ClienteData.fromJson(Map<String, dynamic> json) {
    return ClienteData(
      id: json['id'] as int,
      address: json['address'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      number: json['number'] as String,
      account: Account.fromJson(json['account']),
    );
  }
}

class ClienteResponse {
  final String message;
  final String status;
  final ClienteData data;

  ClienteResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory ClienteResponse.fromJson(Map<String, dynamic> json) {
    return ClienteResponse(
      message: json['message'] as String,
      status: json['status'] as String,
      data: ClienteData.fromJson(json['data']),
    );
  }
}

