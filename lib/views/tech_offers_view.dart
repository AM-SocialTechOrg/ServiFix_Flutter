import 'package:flutter/material.dart';
import 'package:servifix_flutter/api/dto/get_technical_response_by_account.dart';
import 'package:servifix_flutter/api/dto/offer_response.dart';
import 'package:servifix_flutter/api/service/offerService.dart';
import 'package:servifix_flutter/views/publication_view.dart';
import 'package:servifix_flutter/api/dto/publication_response.dart';
import 'package:servifix_flutter/api/service/publicationService.dart';

class TechOffersView extends StatefulWidget {
  final String token;
  final int id;
  final GetTechnicalResponseByAccount technical;

  const TechOffersView({
    Key? key,
    required this.token,
    required this.id,
    required this.technical,
  }) : super(key: key);

  @override
  State<TechOffersView> createState() => _TechOffersViewState();
}

class _TechOffersViewState extends State<TechOffersView> {
  List<OfferResponse2> _offers = [];

  @override
  void initState() {
    super.initState();
    _loadOffers();
  }

  Future<void> _loadOffers() async {
    try {
      List<OfferResponse2> offers = await OfferService().getOffersByTechnicalId(widget.token, widget.technical.technicalId);
      setState(() {
        _offers = offers;
      });
    } catch (e) {
      print('Error al cargar las ofertas: $e');
      // Aquí podrías mostrar un diálogo de error o un mensaje más informativo según sea necesario
    }
  }

  void _navigateToPublicationView(BuildContext context, int publicationId) async {
    try {
      PublicationResponse publication = await PublicationService().getPublicationById(publicationId.toString(), widget.token);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PublicationView(
            token: widget.token,
            technicalId: widget.technical.technicalId,
            publication: publication,
          ),
        ),
      );
    } catch (e) {
      print('Error al cargar la publicación: $e');
      // Aquí podrías mostrar un diálogo de error o un mensaje más informativo según sea necesario
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ofertas Realizadas',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: _offers.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _offers.length,
        itemBuilder: (context, index) {
          final offer = _offers[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Oferta ${offer.id}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Disponibilidad: ${offer.availability}'),
                  Text('Monto: ${offer.amount.toString()}'),
                  Text('Descripción: ${offer.description}'),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildOfferStatus(offer.stateOffer.id),
                      ElevatedButton(
                        onPressed: () {
                          _navigateToPublicationView(context, offer.publication.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1769FF),
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          minimumSize: Size(0, 28),
                        ),
                        child: Text('Ver Publicación',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                      ),)
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOfferStatus(int state) {
    String statusText = '';
    Color statusColor = Colors.grey;

    switch (state) {
      case 1:
        statusText = 'Aceptado';
        statusColor = Colors.green;
        break;
      case 2:
        statusText = 'Rechazado';
        statusColor = Colors.red;
        break;
      default:
        statusText = 'Pendiente';
        statusColor = Colors.orange;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            state == 1 ? Icons.check_circle : Icons.cancel,
            color: statusColor,
          ),
          SizedBox(width: 8),
          Text(
            statusText,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
