import 'package:flutter/material.dart';
import 'package:servifix_flutter/api/dto/get_technical_response_by_account.dart';
import 'package:servifix_flutter/views/tech_offers_view.dart';
import 'package:servifix_flutter/views/tech_profile.dart';
import 'package:servifix_flutter/views/tech_search_view.dart';

class TechHomePage extends StatefulWidget {
  final String token;
  final int id;
  final GetTechnicalResponseByAccount technical;

  const TechHomePage({
    Key? key,
    required this.token,
    required this.id,
    required this.technical,
  }) : super(key: key);

  @override
  _TechHomePageState createState() => _TechHomePageState();
}

class _TechHomePageState extends State<TechHomePage> {
  int _selectedIndex = 2;

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      TechOffersView(token: widget.token, id: widget.id, technical: widget.technical),
      TechSearchView(token: widget.token, technical: widget.technical),
      TechnicalProfileScreen(token: widget.token, id: widget.id, technical: widget.technical),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}