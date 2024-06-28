import 'package:flutter/material.dart';
import 'package:servifix_flutter/api/preferences/userPreferences.dart';
import 'package:servifix_flutter/api/service/PublicationService.dart';
import 'package:servifix_flutter/api/dto/publication_response.dart';

class TechSearchView extends StatefulWidget {
  final String token;

  const TechSearchView({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<TechSearchView> createState() => _TechSearchViewState();
}

class _TechSearchViewState extends State<TechSearchView> {
  late String _token;
  Future<List<PublicationResponse>>? _publicationsFuture;

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

  Widget _buildPublicationCard(BuildContext context,
      {required String title,
        required String address,
        required String technician,
        required String description}) {
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
                    // Acción para ver detalles
                  },
                  child: Text('Ver detalles'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Acción para hacer oferta
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
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}