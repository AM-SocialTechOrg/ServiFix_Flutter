
class StateOffer {
  int id;
  String state;

  StateOffer({
    required this.id,
    required this.state,
  });

  factory StateOffer.fromJson(Map<String, dynamic> json) {
    return StateOffer(
      id: json['id'],
      state: json['state'],
    );
  }
}