import 'package:flutter/material.dart';
import 'package:servifix_flutter/api/dto/get_technical_response_by_account.dart';
import 'package:servifix_flutter/api/dto/offer_request.dart';
import 'package:servifix_flutter/api/preferences/userPreferences.dart';
import 'package:servifix_flutter/api/service/PublicationService.dart';
import 'package:servifix_flutter/api/dto/publication_response.dart';
import 'package:servifix_flutter/api/service/offerService.dart';
import 'package:servifix_flutter/views/publication_view.dart';
import 'package:servifix_flutter/views/tech_profile.dart';

class TechSearchView extends StatefulWidget {
  final String token;
  final GetTechnicalResponseByAccount technical;

  const TechSearchView({
    Key? key,
    required this.token,
    required this.technical,
  }) : super(key: key);

  @override
  State<TechSearchView> createState() => _TechSearchViewState();
}

class _TechSearchViewState extends State<TechSearchView> {
  late String _token;
  Future<List<PublicationResponse>>? _publicationsFuture;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  TextEditingController _tarifaController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _token = widget.token;
    _loadUserPreferences();
  }

  Future<void> _loadUserPreferences() async {
    setState(() {
      _publicationsFuture = PublicationService().getAllPublications(_token);
    });
  }

  Widget _buildPublicationDetail({required String title, required String content}) {
    return RichText(
      text: TextSpan(
        text: '$title: ',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        children: <TextSpan>[
          TextSpan(
            text: content,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  //Agregar una oferta
  void _showOfferServiceSheet(BuildContext context, int publicationId) {
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
                'Hacer oferta',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 8),
              Text(
                'Elige una fecha y horario para realizar el servicio.',
                style: TextStyle(fontSize: 16, color: Color(0xFF4D4D4D)),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1),
                        );
                        if (pickedDate != null && pickedDate != _selectedDate) {
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        }
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Color(0xFFF4F4F4), width: 1.0),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Color(0xFF4D4D4D),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                              style: TextStyle(
                                color: Color(0xFF4D4D4D),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: _selectedTime,
                        );
                        if (pickedTime != null && pickedTime != _selectedTime) {
                          setState(() {
                            _selectedTime = pickedTime;
                          });
                        }
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Color(0xFFF4F4F4), width: 1.0),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Color(0xFF4D4D4D),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '${_selectedTime.format(context)}',
                              style: TextStyle(
                                color: Color(0xFF4D4D4D),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                '¿Cuál es la tarifa que cobrarás por el servicio?',
                style: TextStyle(fontSize: 16, color: Color(0xFF4D4D4D)),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _tarifaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Tarifa',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        suffixText: 'soles',
                        suffixStyle: TextStyle(color: Colors.black),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Puedes añadir una breve descripción sobre el trabajo a realizar.',
                style: TextStyle(fontSize: 16, color: Color(0xFF4D4D4D)),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _descripcionController,
                maxLines: 5, // Permite múltiples líneas de texto
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
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  createOffer(publicationId);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF1769FF),
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Text('Aceptar'),
              ),
              SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }

  Future<void> createOffer(int id) async{
    String formattedDate = "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";
    String formattedTime = "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}";
    final _availability = "$formattedDate $formattedTime";

     final offer = OfferRequest(
      availability: _availability,
      amount: double.parse(_tarifaController.text),
      description: _descripcionController.text,
      technical: widget.technical.technicalId,
      publication: id,
      stateOffer: 1,
     );

     print('Oferta a crear' + offer.toString());
     print('id del técnico: ' + widget.technical.technicalId.toString());
     print('id de la publicación: ' + id.toString());

     try {
       final offerRes = await OfferService().createOffer(_token, offer);

       if(offerRes != null){
         print('Oferta creada');
         print(offerRes);
       }
     }
      catch(e){
        print('Error al crear oferta');
      }
  }

  Widget _buildPublicationCard(BuildContext context,
      {required String title,
        required String address,
        required String technician,
        required String description,
        required PublicationResponse publication,
      }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    _buildPublicationDetail(title: 'Dirección', content: address),
                    _buildPublicationDetail(title: 'Técnico', content: technician),
                    RichText(
                      text: TextSpan(
                        text: 'Descripción: ',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: description.length > 50 ? description.substring(0, 40) + '...' : description,
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PublicationView(token: _token, technicalId: widget.technical.technicalId, publication: publication)
                    ));
                  },
                  child: Text('Ver detalles'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _showOfferServiceSheet(context, publication.id);
                  },
                  child: Text('Hacer oferta'),
                ),
              ],
            ),
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
          icon: Icon(Icons.sort),
          onPressed: () {},
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Búsqueda',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
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
                  return _buildPublicationCard(
                    context,
                    title: publication.title,
                    address: publication.address,
                    technician: publication.job.name,
                    description: publication.description,
                    publication: publications[index],
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
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).pushNamed('/');
          } else if (index == 1) {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => TechSearchView(token: _token, technical: widget.technical),),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TechnicalProfileScreen(token: _token, id: widget.technical.technicalId, technical: widget.technical)),
            );
          }
        },
      ),
    );
  }
}