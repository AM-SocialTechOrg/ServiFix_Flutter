import 'package:flutter/material.dart';
import 'package:servifix_flutter/api/preferences/userPreferences.dart';
import 'package:servifix_flutter/views/user_profile.dart';
import 'package:servifix_flutter/api/dto/get_user_response_by_account.dart';
import 'package:servifix_flutter/api/service/userService.dart';

class Offer extends StatefulWidget {
  const Offer({Key? key}) :super(key: key);


  @override
  State<Offer> createState() => _OfferState();
}

class _OfferState extends State<Offer> {
  late String token;
  late int userId;
  late GetUserResponseByAccount cliente;

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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0, 28),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.local_offer, size: 16, color: Colors.white),
                        SizedBox(width: 4),
                        Text('Ver ofertas', style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0, 28),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.edit, size: 16, color: Colors.white),
                        SizedBox(width: 4),
                        Text('Editar', style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0, 28),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.delete, size: 16, color: Colors.white),
                        SizedBox(width: 4),
                        Text('Eliminar', style: TextStyle(fontSize: 10, color: Colors.white),
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
        leading: IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Buscar por técnico',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Mis solicitudes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildRequestCard(
                    context,
                    title: 'Reparación de fuga en baño',
                    address: 'Calle Principal #123, Lima',
                    technician: 'Gasfitero',
                    description:
                    'Se necesita un gasfitero experimentado para reparar una fuga...',
                  ),
                  SizedBox(height: 10),
                  _buildRequestCard(
                    context,
                    title: 'Instalación de Calentador de Agua',
                    address: 'Calle Principal #123, Lima',
                    technician: 'Gasfitero',
                    description:
                    'Necesitamos un técnico especializado en instalaciones de font...',
                  ),
                ],
              ),
            ),
          ],
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
              MaterialPageRoute(builder: (context) => Offer()),
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
