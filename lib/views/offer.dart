import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api/provider/AuthModel.dart';
import 'package:servifix_flutter/api/service/offerService.dart';
import 'package:servifix_flutter/api/dto/offer_response.dart';
import 'package:servifix_flutter/api/dto/offer_request.dart';

class Offer extends StatefulWidget {
  const Offer({super.key});

  @override
  State<Offer> createState() => _OfferState();
}

class _OfferState extends State<Offer> {
  Future<List<OfferResponse>>? _offersFuture;

  @override
  void initState() {
    super.initState();
    _loadOffers();
  }

  void _loadOffers() {
    final authModel = Provider.of<Authmodel>(context, listen: false);
    final publicationId = authModel.getPublicId;
    final token = authModel.getToken;

    setState(() {
      _offersFuture = OfferService().getOffersByPublicationId(token, publicationId);
    });
  }

  Future<void> _updateOfferState(String token, OfferResponse offer, int newState) async {
    final offerRequest = OfferRequest(
      availability: offer.availability,
      amount: offer.amount,
      description: offer.description,
      technical: offer.technical.id,
      publication: offer.publication.id,
      stateOffer: newState,
    );

    try {
      await OfferService().updateOffer(token, offerRequest, offer.id.toString());
      _loadOffers(); // Reload offers to reflect the updated state
    } catch (e) {
      print('Error updating offer: $e');
      // Handle error accordingly
    }
  }

  Widget _buildRequestCard(
      BuildContext context, {
        required OfferResponse offer,
        required String title,
        required String job,
        required String amount,
        required String description,
        required String state,
      }) {
    final authModel = Provider.of<Authmodel>(context, listen: false);
    final token = authModel.getToken;

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
                    title,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Técnico: $job',
                    style: TextStyle(fontSize: 13),
                  ),
                  Text(
                    'Tarifa: S/$amount',
                    style: TextStyle(fontSize: 13),
                  ),
                  Text(
                    'Descripción: $description',
                    style: TextStyle(fontSize: 13),
                  ),
                  Text(
                    'Estado: $state',
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
                        MaterialPageRoute(builder: (context) => Offer()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      minimumSize: Size(0, 28),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.person, size: 16, color: Colors.white),
                        SizedBox(width: 10),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Perfil',
                              style: TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _updateOfferState(token, offer, 2); // 1 = Accepted state
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      minimumSize: Size(0, 28),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, size: 16, color: Colors.white),
                        SizedBox(width: 10),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Aceptar',
                              style: TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _updateOfferState(token, offer, 3); // 2 = Rejected state
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      minimumSize: Size(0, 28),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.cancel, size: 16, color: Colors.white),
                        SizedBox(width: 10),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Rechazar',
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
        actions: [
          Expanded(
            child: Center(
              child: Text('Ofertas', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 0),
        child: FutureBuilder<List<OfferResponse>>(
          future: _offersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No se encontraron ofertas.'));
            } else {
              final offers = snapshot.data!;
              return ListView.builder(
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  final offer = offers[index];
                  return _buildRequestCard(
                    context,
                    offer: offer,
                    title: offer.technical.account.firstName + ' ' + offer.technical.account.lastName,
                    job: offer.publication.job.name,
                    amount: offer.amount.toString(),
                    description: offer.description,
                    // SI EL VALOR DE STATE ES 1, SE MUESTRA "PENDIENTE"
                    // SI EL VALOR DE STATE ES 2, SE MUESTRA "ACEPTADO"
                    // SI EL VALOR DE STATE ES 2, SE MUESTRA "RECHAZADO"
                    // converitir a entero para comparar
                    //state: "estado de la oferta",
                    state: offer.stateOffer.id == 1 ? "Disponible" : offer.stateOffer.id == 2 ? "Aceptado" : "Rechazado",);
                },
              );
            }
          },
        ),
      ),
    );
  }
}