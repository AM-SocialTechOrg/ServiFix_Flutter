import 'package:flutter/material.dart';
import 'package:servifix_flutter/api/preferences/userPreferences.dart';
import 'package:servifix_flutter/views/user_profile.dart';
import 'package:servifix_flutter/api/dto/get_user_response_by_account.dart';
import 'package:servifix_flutter/api/service/userService.dart';
import 'package:servifix_flutter/views/notification.dart';
import 'package:servifix_flutter/views/offer.dart';
import 'package:servifix_flutter/api/service/PublicationService.dart';
import 'package:servifix_flutter/api/dto/publication_response.dart';
import 'package:servifix_flutter/api/dto/publication_request.dart';

class RequestOffer extends StatefulWidget {
  const RequestOffer({Key? key}) : super(key: key);

  @override
  State<RequestOffer> createState() => _OfferState();
}

class _OfferState extends State<RequestOffer> {
  late String token;
  late int userId;
  late GetUserResponseByAccount cliente;
  Future<List<PublicationResponse>>? _publicationsFuture;

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

    GetUserResponseByAccount _cliente =
    await clienteService.getUserByAccountId(userId, token);
    cliente = _cliente;

    setState(() {
      _publicationsFuture =
          PublicationService().getPublications(cliente.id.toString(), token);
    });
  }

  Future<void> _editPublication(String publicationId, PublicationRequest publicationRequest) async {
    try {
      await PublicationService().editPublication(publicationId, token, publicationRequest.toJson());
      setState(() {
        _publicationsFuture =
            PublicationService().getPublications(cliente.id.toString(), token);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error editing publication: $e')),
      );
    }
  }

  Future<void> _deletePublication(String publicationId) async {
    try {
      await PublicationService().deletePublication(publicationId, token);
      setState(() {
        _publicationsFuture =
            PublicationService().getPublications(cliente.id.toString(), token);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting publication: $e')),
      );
    }
  }

  void _showEditDialog(BuildContext context, PublicationResponse publication) {
    final titleController = TextEditingController(text: publication.title);
    final descriptionController = TextEditingController(text: publication.description);
    final amountController = TextEditingController(text: publication.amount.toString());
    final pictureController = TextEditingController(text: publication.picture);
    final addressController = TextEditingController(text: publication.address);
    final userController = TextEditingController(text: publication.user.id.toString());
    final jobController = TextEditingController(text: publication.job.id.toString());
    final jobNameController = TextEditingController(text: publication.job.name);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Publicación'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Título'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Descripción'),
                ),
                TextField(
                  controller: pictureController,
                  decoration: InputDecoration(labelText: 'Imagen'),
                ),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: 'Dirección'),
                ),

                // espacios
                SizedBox(height: 10),

                DropdownButtonFormField(
                  value: jobController.text,
                  items: [
                    DropdownMenuItem(child: Text('Técnico'), value: '1'),
                    DropdownMenuItem(child: Text('Gasfitero'), value: '2'),
                    DropdownMenuItem(child: Text('Electricista'), value: '3'),
                    DropdownMenuItem(child: Text('Cerrajero'), value: '4'),
                    DropdownMenuItem(child: Text('Pintor'), value: '5'),
                  ],
                  onChanged: (value) {
                    setState(() {
                      jobController.text = value.toString();
                    });
                  },
                  style: TextStyle(color: Color(0xFF4D4D4D), fontSize: 14),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Color(0xFFF4F4F4), width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1769FF), width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    labelStyle: TextStyle(color: Color(0xFFA0A0A0)),
                    labelText: 'Trabajo', // jobNameController.text,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final editedPublication = PublicationRequest(
                  title: titleController.text,
                  description: descriptionController.text,
                  amount: double.parse(amountController.text),
                  picture: pictureController.text,
                  address: addressController.text,
                  user: int.parse(userController.text),
                  job: int.parse(jobController.text),
                );
                _editPublication(publication.id.toString(), editedPublication);
                Navigator.of(context).pop();
              },
              child: Text('Aceptar Cambios'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRequestCard(BuildContext context,
      {required PublicationResponse publication}) {
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
                  Text(
                    publication.title,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Dirección: ${publication.address}',
                    style: TextStyle(fontSize: 13),
                  ),
                  Text(
                    'Técnico: ${publication.job.name}',
                    style: TextStyle(fontSize: 13),
                  ),
                  Text(
                    'Descripción: ${publication.description}',
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
                    onPressed: () {
                      _showEditDialog(context, publication);
                    },
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
                    onPressed: () {
                      _deletePublication(publication.id.toString());
                    },
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
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16.0, left: 5.0),
            child: IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Solicitudes',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16.0, right: 5.0),
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
        child: _publicationsFuture == null
            ? Center(child: CircularProgressIndicator())
            : FutureBuilder<List<PublicationResponse>>(
          future: _publicationsFuture!,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                  child: Text('No se encontraron publicaciones.'));
            } else {
              final publications = snapshot.data!;
              return ListView.builder(
                itemCount: publications.length,
                itemBuilder: (context, index) {
                  final publication = publications[index];
                  return _buildRequestCard(
                    context,
                    publication: publication,
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
              MaterialPageRoute(
                  builder: (context) =>
                      UserProfileScreen(token: token, id: userId, cliente: cliente)),
            );
          }
        },
      ),
    );
  }
}
