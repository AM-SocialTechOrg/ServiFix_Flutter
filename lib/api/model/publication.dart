/*
* {
      "id": 1,
      "title": "Reparación de fuga en baño",
      "description": "Se necesita un gasfitero experimentado para reparar una fuga en la tubería del baño principal. La fuga parece estar cerca del lavamanos y está causando humedad en el suelo.",
      "amount": 50,
      "picture": "https://e.rpp-noticias.io/xlarge/2021/07/24/252325_1123851.jpg",
      "address": "Calle Principal #123, Lima",
      "user": {
        "id": 3,
        "address": "Jhonatan@gmail.com",
        "description": "Soy una persona que necesita de ayuda para sus servicios domesticos",
        "image": "https://pics.craiyon.com/2023-07-15/dc2ec5a571974417a5551420a4fb0587.webp",
        "number": "993058700",
        "account": {
          "id": 19,
          "firstName": "Jhonatan",
          "lastName": "Valdelomar",
          "gender": "Masculino",
          "birthday": "2002-05-31",
          "email": "Jhonatan@gmail.com",
          "password": "$2a$10$.fEq5rraIj5ld4TkuQ/cHu9Ps90iUD.OpUVml76eUAhWLFQRatSrC",
          "role": {
            "id": 1,
            "type": "Usuario"
          }
        }
      },
      "job": {
        "id": 2,
        "name": "Gasfitero",
        "description": "Gasfitero",
        "technicals": []
      }
    }
* */
class Publicaticion {
  final int id;
  final String title;
  final String description;
  final double amount;
  final String picture;
  final String address;

  final Job job;

  Publicaticion({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.picture,
    required this.address,
    required this.job,
  });

  factory Publicaticion.fromJson(Map<String, dynamic> json) {
    return Publicaticion(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      amount: json['amount'] as double,
      picture: json['picture'] as String,
      address: json['address'] as String,

      job: Job.fromJson(json['job']),
    );
  }
}

class Job {
  final int id;
  final String name;


  Job({
    required this.id,
    required this.name

  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}