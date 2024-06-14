import 'package:flutter/material.dart';
import 'package:servifix_flutter/api/dto/get_user_response_by_account.dart';
import 'package:servifix_flutter/api/dto/publication_response.dart';
import 'package:servifix_flutter/api/model/publication.dart';
import 'package:servifix_flutter/api/service/userService.dart';
import 'package:provider/provider.dart';
import 'package:servifix_flutter/api/provider/AuthModel.dart';
import 'package:servifix_flutter/api/service/PublicationService.dart';
import 'package:servifix_flutter/views/request_offer.dart';
import 'package:servifix_flutter/api/preferences/userPreferences.dart';

class UserProfileScreen extends StatefulWidget {
  final String token;
  final int id;
  final GetUserResponseByAccount cliente;

  const UserProfileScreen({
    Key? key,
    required this.token,
    required this.id,
    required this.cliente,
  }) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late String _token;
  late int _userId;
  late GetUserResponseByAccount _cliente;
  Future<List<PublicationResponse>>? _publicationsFuture;

  final PublicationService publicationService = PublicationService();
  final ClientService clienteService = ClientService();

  @override
  void initState() {
    super.initState();
    _loadUserPreferences();
  }

  Future<void> _loadUserPreferences() async {
    UserPreferences userPreferences = UserPreferences();
    _token = (widget.token) ?? '';
    _userId = (widget.id) ?? 0;

    print(_token);
    print(_userId);

    GetUserResponseByAccount cliente = await clienteService.getUserByAccountId(_userId, _token);

    setState(() {
      _cliente = cliente;
      _publicationsFuture = publicationService.getPublications(cliente.id.toString(), _token);
    });
  }

  void _showServiceRequestForm(BuildContext context) {

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Solicitar Servicio',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  items: [
                    DropdownMenuItem(child: Text('Gasfitero'), value: 'Gasfitero'),
                    DropdownMenuItem(child: Text('Electricista'), value: 'Electricista'),
                    DropdownMenuItem(child: Text('Carpintero'), value: 'Carpintero'),
                  ],
                  onChanged: (value) {},
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
                    labelText: '¿Qué profesional necesitas?',
                  ),
                ),
                SizedBox(height: 20),
                _buildTextFormField('Título'),
                SizedBox(height: 20),
                _buildTextFormField('Descripción', maxLines: 3),
                SizedBox(height: 20),
                _buildTextFormField('Dirección'),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextFormField('Subir archivo'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.attach_file),
                      label: Text('Añadir archivo'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _showSuccessDialog(context),
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
                      SizedBox(width: 8),
                      Text(
                        'Publicar solicitud',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Solicitud Publicada'),
          content: Text('Tu solicitud de servicio ha sido publicada exitosamente.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextFormField(String labelText, {int maxLines = 1}) {
    return TextFormField(
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
        labelText: labelText,
      ),
      maxLines: maxLines,
    );
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
              backgroundImage: widget.cliente.image != null
                  ? NetworkImage(widget.cliente.image)
                  : null,
            ),
            SizedBox(height: 10),
            Text(
              widget.cliente != null
                  ? widget.cliente.account.firstName + ' ' + widget.cliente.account.lastName
                  : 'Cargando...',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.cliente != null ? 'Cliente' : 'Cargando...',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showServiceRequestForm(context),
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
                    Icons.edit_document,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Solicitar servicio',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            TabBar(
              tabs: [
                Tab(text: 'Publicaciones'),
                Tab(text: 'Comentarios'),
              ],
              indicatorColor: Colors.blue,
              labelColor: Colors.black,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FutureBuilder<List<PublicationResponse>>(
                    future: _publicationsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error al cargar las publicaciones'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No hay publicaciones'));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final publication = snapshot.data![index];
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
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Descripción: ',
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: publication.description,
                                              style: TextStyle(fontWeight: FontWeight.normal),
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
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: publication.address,
                                              style: TextStyle(fontWeight: FontWeight.normal),
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
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: publication.job.name,
                                              style: TextStyle(fontWeight: FontWeight.normal),
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
                                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                            return Center(child: Icon(Icons.error, size: 50, color: Colors.grey));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
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
                MaterialPageRoute(builder: (context) => UserProfileScreen(token: _token, id: _userId, cliente: _cliente)),
              );
            }
          },
        ),
      ),
    );
  }
}
