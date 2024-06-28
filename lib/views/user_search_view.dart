import 'package:flutter/material.dart';
import 'package:servifix_flutter/views/request_offer.dart';
import 'package:servifix_flutter/views/user_profile.dart';
import 'package:servifix_flutter/api/dto/get_user_response_by_account.dart';
import 'package:servifix_flutter/api/dto/technical_response.dart';
import 'package:servifix_flutter/api/preferences/userPreferences.dart';
import 'package:servifix_flutter/api/service/technicalService.dart';
import 'package:servifix_flutter/api/service/userService.dart';


class user_search_view extends StatefulWidget {
  const user_search_view({super.key});

  @override
  State<user_search_view> createState() => _user_search_viewState();
}

class _user_search_viewState extends State<user_search_view> {
  late String token;
  late int userId;
  late GetUserResponseByAccount cliente;
  Future<List<TechnicalData>>? _technicians;

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
      _technicians = TechnicalService().getAllTechnicians(token);
    });
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: 'Buscar técnico por nombre o habilidad',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      //onChanged: _filterTechnicians,
    );
  }

  Widget _buildRequestCard2(BuildContext context,
      {required String name,
        required String skills,
        required String experience,
        required String number,
        required String gender}) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
            child: Text('$name',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 2, 16, 0),
            child: Text('Habilidades: $skills',
                textAlign: TextAlign.justify),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 2, 16, 0),
            child: Text('Experiencia: $experience',
                textAlign: TextAlign.justify),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 2, 16, 0),
            child: Text('Número de contacto: $number',
                textAlign: TextAlign.justify),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 2, 16, 0),
            child: Text('Género: $gender',
                textAlign: TextAlign.justify),
          ),
          ButtonBar(
            children: [
              TextButton(
                onPressed: () {},
                child: Text('Solicitar'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Expanded(
            child: Center(
              child: Text(
                'Búsqueda de técnicos',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildSearchField(),
            SizedBox(height: 20),
            Expanded(
              child: _technicians == null
                  ? Center(child: CircularProgressIndicator())
                  : FutureBuilder<List<TechnicalData>>(
                future: _technicians!,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No se encontraron técnicos.'));
                  } else {
                    final technicians = snapshot.data!;
                    return ListView.builder(
                      itemCount: technicians.length,
                      itemBuilder: (context, index) {
                        final technician = technicians[index];
                        return _buildRequestCard2(
                          context,
                          name: technician.account.firstName +
                              ' ' +
                              technician.account.lastName,
                          skills: technician.skills,
                          experience: technician.experience,
                          number: technician.number,
                          gender: technician.account.gender,
                        );
                      },
                    );
                  }
                },
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
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RequestOffer()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => user_search_view()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserProfileScreen(
                  token: token,
                  id: userId,
                  cliente: cliente,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}