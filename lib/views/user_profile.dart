import 'package:flutter/material.dart';
import 'package:servifix_flutter/api/model/publication.dart';
import 'package:servifix_flutter/api/service/clienteService.dart';
import 'package:provider/provider.dart';
import 'package:servifix_flutter/api/provider/AuthModel.dart';
import '../api/dto/cliente_response.dart';
import 'package:servifix_flutter/api/service/PublicationService.dart';

class UserProfileScreen extends StatefulWidget {

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  ClienteResponse? _cliente;
  // lista de publicaciones
  List<Publicaticion>? _publicaciones;

  final ClienteService clienteService = ClienteService();
  final PublicationService publicationService = PublicationService();
  @override
  void initState() {
    super.initState();
    print("initState for ProfileScreen");
    _fetchCliente();
    _fetchPublicaciones();
  }

  Future<void> _fetchCliente() async {
    try {
      String token = Provider.of<Authmodel>(context, listen: false).getToken;
      String id = Provider.of<Authmodel>(context, listen: false).getId;
      ClienteResponse cliente = await clienteService.getCliente(id,token);
      setState(() {
        _cliente = cliente;
        print('Cliente: prueba con id');
      });
    } catch (e) {
      print('Error: No devuelve el cliente' + e.toString());
    }
  }

  Future<void> _fetchPublicaciones() async {
    try {
      String token = Provider.of<Authmodel>(context, listen: false).getToken;
      String id = Provider.of<Authmodel>(context, listen: false).getId;
      _publicaciones = await publicationService.getPublications(id,token);
      setState(() {
        print('Publicaciones: prueba con id');
        // ver los elementos publicaciones lista
        _publicaciones!.forEach((element) {
          print("titulo de la publicacion: "+element.toString());
        });
      });
    } catch (e) {
      print('Error: No devuelve las publicaciones' + e.toString());
    }
  }

  void _showServiceRequestForm(BuildContext context) {

    String token = Provider.of<Authmodel>(context, listen: false).getToken;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
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
                  decoration: InputDecoration(
                    labelText: '¿Qué profesional necesitas?',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Dirección',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Subir archivo',
                          border: OutlineInputBorder(),
                        ),
                      ),
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
                    padding: EdgeInsets.symmetric(horizontal: 90), // Define el margen horizontal deseado
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(width: 8), // Espacio entre el icono y el texto
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
              backgroundImage: _cliente != null && _cliente!.data != null && _cliente!.data.image != null
                  ? NetworkImage(_cliente!.data.image)
                  : null,
            ),
            SizedBox(height: 10),

            Text(
              _cliente != null && _cliente!.data != null && _cliente!.data!.account != null
                  ? _cliente!.data!.account!.firstName
                  : 'Cargando...',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              _cliente != null && _cliente!.data != null && _cliente!.data!.account != null
                  ? _cliente!.data!.account!.role!.id == 1 ? 'Cliente' : 'Técnico'
                  : 'Cargando...',

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
                padding: EdgeInsets.symmetric(horizontal: 90), // Define el margen horizontal deseado
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.edit_document, // Icono de añadir
                    color: Colors.white, // Color del icono
                  ),
                  SizedBox(width: 8), // Espacio entre el icono y el texto
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
                                    style: TextStyle(color: Colors.black), // Color para todo el texto
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
                                    style: TextStyle(color: Colors.black), // Color para todo el texto
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
                                      // Si hay un error al cargar la imagen, muestra un icono de error
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
      ),
    );
  }
}
