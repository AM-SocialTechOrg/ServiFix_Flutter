import 'package:flutter/material.dart';
import 'package:servifix_flutter/views/login.dart';

class Success extends StatelessWidget {

  final String token;

  const Success({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(height: 24),
              Text(
                '¡Inicio de sesión exitoso!',
                style: TextStyle(
                  color: Color(0xFF1769FF),
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Esta es una vista de prueba',
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Su token es: ',
                style: TextStyle(
                  color: Color(0xFF1769FF),
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 24),
              Text(
                '$token',
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogIn()),
                  );
                },
                child: Text('Volver al inicio de sesión'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
