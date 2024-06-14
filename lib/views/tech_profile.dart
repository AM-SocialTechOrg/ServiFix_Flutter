import 'package:flutter/material.dart';
import 'package:servifix_flutter/api/dto/get_technical_response_by_account.dart';
import 'package:servifix_flutter/api/model/publication.dart';
import 'package:servifix_flutter/api/service/technicalService.dart';
import 'package:servifix_flutter/api/service/PublicationService.dart';

class TechnicalProfileScreen extends StatefulWidget {
  final String token;
  final int id;
  final GetTechnicalResponseByAccount technical;

  const TechnicalProfileScreen({
    Key? key,
    required this.token,
    required this.id,
    required this.technical,
  }) : super(key: key);

  @override
  _TechnicalProfileScreenState createState() =>
      _TechnicalProfileScreenState();
}

class _TechnicalProfileScreenState
    extends State<TechnicalProfileScreen> {

  List<Publicaticion>? _publicaciones;
  final PublicationService publicationService = PublicationService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {},
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {},
              ),
            ],
          ),
          body: Column(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                backgroundImage: null,
              ),
              SizedBox(height: 10),
              Text(
                widget.technical != null
                    ? widget.technical.account.firstName + ' ' + widget.technical.account.lastName
                    : 'Cargando...',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.technical != null
                    ? 'Técnico'
                    : 'Cargando...',
              ),
              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0, bottom: 0, top: 5.0),
                child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 140,
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFF4F4F4), width: 1.0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.build, // Icono de herramienta
                                  color: Color(0xFF4D4D4D),
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '10', // Número de servicios
                                      style: TextStyle(
                                        color: Color(0xFF4D4D4D),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Servicios',
                                      style: TextStyle(
                                        color: Color(0xFF4D4D4D),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 140,
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFF4F4F4), width: 1.0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star, // Icono de estrella
                                  color: Color(0xFF4D4D4D),
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      '4.5', // Calificación
                                      style: TextStyle(
                                        color: Color(0xFF4D4D4D),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Calificación',
                                      style: TextStyle(
                                        color: Color(0xFF4D4D4D),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color:Color(0xFFF4F4F4), width: 1.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(widget.technical.description.toString(),
                            style: TextStyle(
                              color: Color(0xFF4D4D4D),
                            )
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: Color(0xFF1769FF),
                          elevation: 0,
                          padding: EdgeInsets.symmetric(horizontal: 90),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.edit_note,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Editar',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                ),
              ),
              SizedBox(height: 20),

              TabBar(
                tabs: [
                  Tab(text: 'Experiencia'),
                  Tab(text: 'Comentarios'),
                ],
                indicatorColor: Colors.blue,
                labelColor: Colors.black,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _publicaciones != null
                        ? ListView.builder(
                      itemCount: _publicaciones!.length,
                      itemBuilder: (context, index) {
                        final publication = _publicaciones![index];
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    publication.title,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Descripción: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: publication.description,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Dirección: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: publication.address,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Técnico: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: publication.job.name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    height: 150,
                                    color: Colors.grey[300],
                                    child: Image.network(
                                      publication.picture,
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Center(
                                            child: Icon(Icons.error,
                                                size: 50,
                                                color: Colors.grey));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                        : Center(child: Text('No hay publicaciones')),
                    Center(child: Text('No hay comentarios')),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Solicitudes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Búsqueda',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Perfil',
              ),
            ],
            currentIndex: 2,
          ),
        )
    );
  }
}

