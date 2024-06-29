import 'package:flutter/material.dart';
import 'package:servifix_flutter/api/dto/offer_request.dart';
import 'package:servifix_flutter/api/dto/publication_response.dart';
import 'package:servifix_flutter/api/service/offerService.dart';

class PublicationView extends StatefulWidget {
  final String token;
  final int technicalId;
  final PublicationResponse publication;

  const PublicationView({
    Key? key,
    required this.token,
    required this.technicalId,
    required this.publication,
  }) : super(key: key);

  @override
  _PublicationViewState createState() => _PublicationViewState();
}

class _PublicationViewState extends State<PublicationView> {
  late DateTime _selectedDate = DateTime.now();
  late TimeOfDay _selectedTime = TimeOfDay.now();
  final TextEditingController _tarifaController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  @override
  void dispose() {
    _tarifaController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Ofertas',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.publication.title,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 18),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(widget.publication.user.image),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.publication.user.account.firstName +
                            ' ' +
                            widget.publication.user.account.lastName,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Cliente',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Publication card
              Container(
                width: double.infinity,
                child: Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Descripción',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.publication.description,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Dirección',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.publication.address,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Técnico',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.publication.job.name,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Imágenes adjuntas', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              // Image of the publication
              Image.network(
                widget.publication.picture.isNotEmpty
                    ? widget.publication.picture
                    : 'https://example.com/placeholder-image.png', // URL de una imagen de placeholder o texto alternativo
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text('No hay imágenes adjuntas'),
                  );
                },
              ),
              SizedBox(height: 30),
              // Hacer oferta button
              ElevatedButton(
                onPressed: () {
                  _showOfferServiceSheet(context, widget.publication.id);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  backgroundColor: Color(0xFF1769FF),
                  elevation: 0,
                ),
                child: Text('Hacer oferta',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Ofertas',
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
        selectedItemColor: Colors.blue,
        currentIndex: 1,
        onTap: (index) {
          // Handle taps
        },
      ),
    );
  }

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
                  createOffer(widget.publication.id);
                  _showSuccessDialog(context);
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

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Oferta enviada'),
          content: Text('Tu oferta ha sido enviada exitosamente.'),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> createOffer(int id) async {
    String formattedDate = "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";
    String formattedTime = "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}";

    final _availability = "$formattedDate $formattedTime";

    final offer = OfferRequest(
      availability: _availability,
      amount: double.parse(_tarifaController.text),
      description: _descripcionController.text,
      technical: widget.technicalId,
      publication: id,
      stateOffer: 1,
    );

    print('Oferta a crear' + offer.toString());
    print('id del técnico: ' + widget.technicalId.toString());
    print('id de la publicación: ' + id.toString());

    try {
      final offerRes = await OfferService().createOffer(widget.token, offer);

      if (offerRes != null) {
        print('Oferta creada');
        print(offerRes);
      }
    } catch (e) {
      print('Error al crear oferta');
    }
  }
}
