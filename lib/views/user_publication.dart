import 'package:flutter/material.dart';
import 'package:servifix_flutter/api/service/clienteService.dart';
import 'package:provider/provider.dart';
import 'package:servifix_flutter/api/provider/AuthModel.dart';
import '../api/dto/cliente_response.dart';



class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ClienteResponse? _cliente;
  final ClienteService clienteService = ClienteService();
  @override
  void initState() {
    super.initState();
    print("initState for ProfileScreen");
    _fetchCliente();
  }

  Future<void> _fetchCliente() async {
    try {
      String token = Provider.of<Authmodel>(context, listen: false).getToken;
      ClienteResponse cliente = await clienteService.getCliente('3', token);
      setState(() {
        _cliente = cliente;
        print('Cliente: prueba');
      });
    } catch (e) {
      print('Error: No devuelve el cliente' + e.toString());
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
              child: Icon(Icons.person, size: 50, color: Colors.grey),
            ),
            SizedBox(height: 10),

            Text(
              _cliente != null ? _cliente!.data!.account!.firstName : 'Loading...',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text('Cliente'),
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
                      fontSize: 14,
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
                  ListView(
                    children: [
                      Card(
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Reparación de fuga en baño',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Descripción: Se necesita un gasfitero experimentado para reparar una fuga en la tubería del baño principal. La fuga parece estar cerca del lavamanos y está causando humedad en el suelo.',
                              ),
                              SizedBox(height: 10),
                              Text('Dirección: Calle Principal #123, Lima'),
                              SizedBox(height: 10),
                              Text('Técnico: Gasfitero'),
                              SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                height: 150,
                                color: Colors.grey[300],
                                child: Center(
                                  child: Icon(Icons.image,
                                      size: 50, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
        ),
      ),
    );
  }
}
