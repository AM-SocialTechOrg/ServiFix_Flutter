import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
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
              'Fernando Castillo Díaz',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text('Cliente'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Solicitar servicio'),
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

