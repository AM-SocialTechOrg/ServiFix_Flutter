import 'package:flutter/material.dart';

class offer extends StatefulWidget {
  const offer({super.key});

  @override
  State<offer> createState() => _offerState();
}

class _offerState extends State<offer> {


  Widget _buildRequestCard(
      BuildContext context, {
        required String title,
        required String job,
        required String amount,
        required String description,
        required String state
      }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 210,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Técnico: $job',
                    style: TextStyle(fontSize: 13),
                  ),
                  Text(
                    'Tarifa: S/$amount',
                    style: TextStyle(fontSize: 13),
                  ),
                  Text(
                    'Descripción: $description',
                    style: TextStyle(fontSize: 13),
                  ),
                  Text(
                    'Estado: $state',
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: 100,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => offer()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      minimumSize: Size(0, 28),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.person, size: 16, color: Colors.white),
                        SizedBox(width: 10),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Perfil',
                              style: TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      minimumSize: Size(0, 28),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, size: 16, color: Colors.white),
                        SizedBox(width: 10),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Aceptar',
                              style: TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      minimumSize: Size(0, 28),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.cancel, size: 16, color: Colors.white),
                        SizedBox(width: 10),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Rechazar',
                              style: TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Expanded(
            child: Center(
              child: Text('Ofertas',
                  style: TextStyle(fontSize: 20)
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Text('Ofrezco servicios para pintar paredes externas',
                style: TextStyle(
                  fontSize: 15,
                )
            ),*/
            Row(
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.sort)),
                SizedBox(width: 10),
                Text('Ordenar por:'),
              ]
            ),
            SizedBox(height: 5),
            Expanded(
              child: ListView(
                children: [
                  _buildRequestCard(
                      context,
                      title: 'Mateo lopez Castro',
                      job: 'Pintor',
                      amount: '200',
                      description: 'Pintura de paredes externas de 2 pisos',
                      state: 'Pendiente'
                  ),
                ]
              ),
            )
          ],
        ),
      )
    );
  }
}
