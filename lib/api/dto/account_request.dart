class AccountRequest {
  String firstName;
  String lastName;
  String gender;
  String birthday;
  String email;
  String password;
  int role;

  AccountRequest({
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