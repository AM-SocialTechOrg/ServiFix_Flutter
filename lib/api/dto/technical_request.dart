class TechnicalRequest {
  final String policeRecords;
  final String skills;
  final String experience;
  final String number;
  final String description;
  final int accountId;

  TechnicalRequest({
    required this.policeRecords,
    required this.skills,
    required this.experience,
    required this.number,
    required this.description,
    required this.accountId,
  });

  Map<String, dynamic> toJson() {
    return {
      "policeRecords": policeRecords,
      "skills": skills,
      "experience": experience,
      "number": number,
      "description": description,
      "account": accountId,
    };
  }
}
