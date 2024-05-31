import 'package:flutter/material.dart';

import 'login.dart';

class SuccessfulRegistration extends StatefulWidget {
  final String name;
  final String lastname;
  final String dni;
  final String email;
  final String password;
  final String user;

  const SuccessfulRegistration({
    Key? key,
    required this.name,
    required this.lastname,
    required this.dni,
    required this.email,
    required this.password,
    required this.user,
  }) : super(key: key);

  @override
  State<SuccessfulRegistration> createState() => _SuccessfulRegistrationState();
}

class _SuccessfulRegistrationState extends State<SuccessfulRegistration> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 48.0, left: 48.0, top: 56.0, bottom: 48.0),
          child: Column(
            children: [
              Image(
                image: AssetImage('lib/assets/tools.png'),
                width: 40,
                height: 40,
              ),

              SizedBox(height: 8),
              Text(
                'Registro',
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 8),

              Column(
                children: [
                  Text('${widget.name} ${widget.lastname}',
                    style: TextStyle(
                      color: Color(0xFF67A1FF),
                      fontSize: 16,
                    ),),
                  Text('${widget.email}',
                    style: TextStyle(
                      color: Color(0xFFA0A0A0),
                      fontSize: 12,
                    ),),
                ],
              ),

              SizedBox(height: 32),

              Text('¡Gracias por registrarte en ServiFix!',
                style: TextStyle(
                  color: Color(0xFF1769FF),
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 24),

              Text(
                widget.user == 'trabajador'
                    ? 'Te notificaremos por correo electrónico cuando tu cuenta esté activada y puedas empezar a realizar servicios.'
                    : '',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                widget.user == 'trabajador'
                    ? 'Mientras tanto, puedes iniciar sesión y agregar información en tu perfil profesional.'
                    : 'Inicia sesión para descubrir todas las funciones.',
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 16),

              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                    );
                  },
                child: const Text(
                  'Ir al inicio de sesión',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 14,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  backgroundColor: Color(0xFF1769FF),
                  elevation: 0,
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
