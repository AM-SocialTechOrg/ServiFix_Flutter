class RegisterRequest {
  final String firstName;
  final String lastName;
  final String gender;
  final String birthday;
  final String email;
  final String password;
  final int role;

  RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthday,
    required this.email,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'birthday': birthday,
      'email': email,
      'password': password,
      'role': role,
    };
  }
}
