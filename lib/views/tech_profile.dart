import 'package:flutter/material.dart';
import 'package:servifix_flutter/api/dto/get_technical_response_by_account.dart';
import 'package:servifix_flutter/api/dto/technical_request.dart';
import 'package:servifix_flutter/api/model/publication.dart';
import 'package:servifix_flutter/api/preferences/userPreferences.dart';
import 'package:servifix_flutter/api/service/technicalService.dart';
import 'package:servifix_flutter/api/service/PublicationService.dart';
import 'package:servifix_flutter/views/tech_search_view.dart';

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

class _TechnicalProfileScreenState extends State<TechnicalProfileScreen> {
  late String _token;
  late int _id;
  late GetTechnicalResponseByAccount _technical;

  List<Publicaticion>? _publicaciones;
  final PublicationService publicationService = PublicationService();

  @override
  void initState() {
    super.initState();
    _token = (widget.token) ?? '';
    _id = (widget.id) ?? 0;
    _technical = (widget.technical);
  }

  void updateData() async {
    GetTechnicalResponseByAccount technical = await TechnicalService().getTechnicianByAccountId(_id, _token);
    setState(() {
      _technical = technical;
    });
  }

  void updateTechnical(TechnicalRequest technical) async {
    TechnicalService technicalService = TechnicalService();

    try{
      print('Actualizando perfil...');
      final response = await technicalService.updateTechnical(technical, _token);
      if(response.status == 'SUCCESS') {
        print('Perfil actualizado');
        updateData();
      } else {
        print('Error al actualizar perfil');
      }
    } catch (e) {
      print('Error al actualizar perfil');
    }
  }

  void showEditProfileSheet(BuildContext context, GetTechnicalResponseByAccount technical) {
    TextEditingController policeRecordsController = TextEditingController(text: technical.policeRecords ?? '');
    TextEditingController skillsController = TextEditingController(text: technical.skills ?? '');
    TextEditingController experienceController = TextEditingController(text: technical.experience ?? '');
    TextEditingController numberController = TextEditingController(text: technical.number ?? '');
    TextEditingController descriptionController = TextEditingController(text: technical.description ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 30,
            right: 30,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  color: Colors.grey[300],
                  margin: EdgeInsets.only(bottom: 16),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Editar perfil',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 8),
              Text(
                'Antecedentes policiales',
                style: TextStyle(fontSize: 16, color: Color(0xFF4D4D4D)),
              ),
              _buildTextFieldWithIcon(
                controller: policeRecordsController,
                labelText: 'Antecedentes policiales',
                icon: Icons.assignment,
              ),
              SizedBox(height: 8),
              Text(
                'Habilidades',
                style: TextStyle(fontSize: 16, color: Color(0xFF4D4D4D)),
              ),
              _buildTextFieldWithIcon(
                controller: skillsController,
                labelText: 'Habilidades',
                icon: Icons.build,
              ),
              SizedBox(height: 8),
              Text(
                'Experiencia',
                style: TextStyle(fontSize: 16, color: Color(0xFF4D4D4D)),
              ),
              _buildTextFieldWithIcon(
                controller: experienceController,
                labelText: 'Experiencia',
                icon: Icons.work,
              ),
              SizedBox(height: 8),
              Text(
                'Teléfono',
                style: TextStyle(fontSize: 16, color: Color(0xFF4D4D4D)),
              ),
              _buildTextFieldWithIcon(
                controller: numberController,
                labelText: 'Número',
                icon: Icons.phone,
              ),
              SizedBox(height: 8),
              Text(
                'Descripción',
                style: TextStyle(fontSize: 16, color: Color(0xFF4D4D4D)),
              ),
              TextField(
                controller: descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Descripción',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  TechnicalRequest technical = TechnicalRequest(
                    policeRecords: policeRecordsController.text,
                    skills: skillsController.text,
                    experience: experienceController.text,
                    number: numberController.text,
                    description: descriptionController.text,
                    accountId: _technical.account.id,
                  );

                  updateTechnical(technical);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF1769FF),
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Text('Guardar cambios'),
              ),
              SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextFieldWithIcon({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(
              icon,
              color: Color(0xFF4D4D4D),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: labelText,
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ),
        ],
      ),
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
                backgroundImage: null,
              ),
              SizedBox(height: 10),
              Text(
                _technical != null
                    ? _technical.account.firstName + ' ' + _technical.account.lastName
                    : 'Cargando...',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                _technical != null
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
                        child: Text(_technical.description.toString(),
                            style: TextStyle(
                              color: Color(0xFF4D4D4D),
                            )
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          showEditProfileSheet(context, _technical);
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
                    SingleChildScrollView(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: Icon(Icons.work),
                            title: Text('Experiencia'),
                            subtitle: Text(_technical.experience ?? 'No especificada'),
                          ),
                          SizedBox(height: 16),
                          ListTile(
                            leading: Icon(Icons.build),
                            title: Text('Habilidades'),
                            subtitle: Text(_technical.skills ?? 'No especificadas'),
                          ),
                          SizedBox(height: 16),
                          ListTile(
                            leading: Icon(Icons.assignment),
                            title: Text('Antecedentes Policiales'),
                            subtitle: Text(_technical.policeRecords ?? 'No especificados'),
                          ),
                          SizedBox(height: 16),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text('Número de Contacto'),
                            subtitle: Text(_technical.number ?? 'No especificado'),
                          ),
                          // Agrega más ListTile según sea necesario para mostrar más propiedades
                        ],
                      ),
                    ),
                    Center(child: Text('No hay comentarios')),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}

