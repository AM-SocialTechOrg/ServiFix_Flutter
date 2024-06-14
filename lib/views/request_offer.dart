import 'package:flutter/material.dart';
import 'package:servifix_flutter/api/preferences/userPreferences.dart';
import 'package:servifix_flutter/views/user_profile.dart';
import 'package:servifix_flutter/api/dto/get_user_response_by_account.dart';
import 'package:servifix_flutter/api/service/userService.dart';
import 'package:servifix_flutter/views/notification.dart';
import 'package:servifix_flutter/views/offer.dart';
import 'package:servifix_flutter/api/service/PublicationService.dart';
import 'package:servifix_flutter/api/dto/publication_response.dart';

class RequestOffer extends StatefulWidget {
  const RequestOffer({Key? key}) :super(key: key);


  @override
  State<RequestOffer> createState() => _OfferState();
}

class _OfferState extends State<RequestOffer> {
  late String token;
  late int userId;
  late GetUserResponseByAccount cliente;
  late Future<List<PublicationResponse>> _publicationsFuture;

  @override
  void initState() {
    super.initState();
    _loadUserPreferences();
  }

  Future<void> _loadUserPreferences() async {
    ClientService clienteService = ClientService();
    UserPreferences userPreferences = UserPreferences();
    token = (await userPreferences.getToken()) ?? '';
    userId = (await userPreferences.getUserId()) ?? 0;

    GetUserResponseByAccount _cliente = await clienteService.getUserByAccountId(userId, token);
    cliente = _cliente;
    setState(() {
      _publicationsFuture = PublicationService().getPublications(cliente.id.toString(), token);
    });
  }


  Widget _buildRequestCard(
      BuildContext context, {
        required String title,
        required String address,
        required String technician,
        required String description,
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
                    'Dirección: $address',
                    style: TextStyle(fontSize: 13),
                  ),
                  Text(
                    'Técnico: $technician',
                    style: TextStyle(fontSize: 13),
                  ),
                  Text(
                    'Descripción: $description',
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
                      backgroundColor: Colors.green[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      minimumSize: Size(0, 28),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.local_offer, size: 16, color: Colors.white),
                        SizedBox(width: 4),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Ver ofertas',
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
                      backgroundColor: Colors.blue[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      minimumSize: Size(0, 28),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.edit, size: 16, color: Colors.white),
                        SizedBox(width: 4),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Editar',
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
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      minimumSize: Size(0, 28),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.delete, size: 16, color: Colors.white),
                        SizedBox(width: 4),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Eliminar',
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
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
              },
            ),
          ),
          Expanded(
            child: Center(
              child: Text('Solicitudes',
                  style: TextStyle(fontSize: 20)
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16.0),
            child: IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => notification()),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<PublicationResponse>>(
          future: _publicationsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No se encontraron publicaciones.'));
            } else {
              final publications = snapshot.data!;
              return ListView.builder(
                itemCount: publications.length,
                itemBuilder: (context, index) {
                  final publication = publications[index];
                  return _buildRequestCard(
                    context,
                    title: publication.title,
                    address: publication.address,
                    technician: publication.job.name,
                    description: publication.description,
                  );
                },
              );
            }
          },
        ),
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
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RequestOffer()),
            );
          } else if (index == 1) {
            Navigator.of(context).pushNamed('/search');
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserProfileScreen(token: token, id: userId, cliente: cliente)),
            );
          }
        },
      ),
    );
  }
}
