import 'dart:ffi';

import 'package:flutter/material.dart';

class Register1 extends StatefulWidget {
  const Register1({Key? key}) : super(key: key);

  @override
  State<Register1> createState() => _Register1State();
}

class _Register1State extends State<Register1> {
  String _selectedUser = 'technician';
  bool _accept = false;

  void dropDownChanged(String? value) {
    setState(() {
      _selectedUser = value ?? 'technician';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(48.0),
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

                Container(
                  width: 152,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedUser,
                    items: const <DropdownMenuItem<String>>[
                      DropdownMenuItem<String>(
                        value: 'technician',
                        child: Text('Trabajador'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'client',
                        child: Text('Cliente'),
                      ),
                    ],
                    onChanged: dropDownChanged,
                    style: TextStyle(
                      color: Color(0xFF4D4D4D),
                      fontSize: 14,
                    ),
                    underline: Container(),
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 24,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Color(0xFFF4F4F4), width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1769FF), width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    labelText: 'Nombres',
                    labelStyle: TextStyle(color: Color(0xFFA0A0A0)),
                  ),
                ),

                SizedBox(height: 16),

                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Color(0xFFF4F4F4), width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1769FF), width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    labelText: 'Apellidos',
                    labelStyle: TextStyle(color: Color(0xFFA0A0A0)),
                  ),
                ),

                SizedBox(height: 16),

                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Color(0xFFF4F4F4), width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1769FF), width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    labelText: 'DNI',
                    labelStyle: TextStyle(color: Color(0xFFA0A0A0)),
                  ),
                ),

                SizedBox(height: 16),

                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Color(0xFFF4F4F4), width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1769FF), width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    labelText: 'Correo electrónico',
                    labelStyle: TextStyle(color: Color(0xFFA0A0A0)),
                  ),
                ),

                SizedBox(height: 16),

                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Color(0xFFF4F4F4), width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1769FF), width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(color: Color(0xFFA0A0A0)),
                  ),
                ),

                SizedBox(height: 16),

                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Color(0xFFF4F4F4), width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF1769FF), width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    labelText: 'Repetir contraseña',
                    labelStyle: TextStyle(color: Color(0xFFA0A0A0)),
                  ),
                ),

                SizedBox(height: 24),

                Row(
                  children: [
                    Switch(
                        value: _accept ,
                        onChanged: (value) {
                        setState(() {
                          _accept = value;
                        });
                    }),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        'Acepto los términos y condiciones',
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {
                    // Add code here
                  },
                  child: const Text(
                    'Iniciar Sesión',
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
                  ),
                ),

                TextButton(
                  child: Text(
                    'Ya tengo una cuenta',
                    style: TextStyle(
                      color: Color(0xFF67A1FF),
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () {
                    // Add code here
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
