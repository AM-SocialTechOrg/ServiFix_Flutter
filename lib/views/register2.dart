import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:servifix_flutter/views/login.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:servifix_flutter/views/register3.dart';

class Register2 extends StatefulWidget {

  final String name;
  final String lastname;
  final String gender;
  final DateTime birthday;
  final String dni;
  final String email;
  final String password;
  final String user;

  const Register2({
    Key? key,
    required this.name,
    required this.lastname,
    required this.gender,
    required this.birthday,
    required this.dni,
    required this.email,
    required this.password,
    required this.user,
  }) : super(key: key);


  @override
  State<Register2> createState() => _Register2State();
}

class _Register2State extends State<Register2> {

  TextEditingController fileController = TextEditingController(text: 'Seleccionar archivo');
  bool _isfileSelected = false;

  void isfileSelected() {
    setState(() {
      _isfileSelected = true;
    });
  }

  clearFields() {
    fileController.clear();
  }

  @override
  Widget build(BuildContext context) {

    isfileSelected();

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

                SizedBox(height: 24),

                Text(
                  'Estimado trabajador, para garantizar la seguridad y confianza de todos los usuarios, es imprescindible que subas tu certificado de antecedentes policiales.',
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 16),

                Text(
                  'Esto nos permite asegurar que todos nuestros colaboradores cumplen con los estándares de integridad necesarios para brindar un servicio de calidad y mantener un entorno seguro para nuestra comunidad de usuarios.',
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 16),

                Text(
                  'Recuerda que tus datos pasarán por un proceso de verificación antes de activar tu cuenta.',
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 16),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: _isfileSelected ? Color(0xFF1769FF) : Color(0xFFF4F4F4), width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    fileController.text,
                    style: TextStyle(
                      color: _isfileSelected ? Color(0xFF4D4D4D) : Color(0xFFA0A0A0),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                ElevatedButton(
                  onPressed: ()  {

                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Color(0xFF67A1FF),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.attach_file,
                          color: Colors.white,

                        ),
                      ),
                      Text(
                        'Añadir archivo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register3(
                      name:  widget.name,
                      lastname: widget.lastname,
                      gender: widget.gender,
                      birthday: widget.birthday,
                      dni: widget.dni,
                      email: widget.email,
                      password: widget.password,
                      user: widget.user)
                      ),
                    );
                  },
                  child: const Text(
                    'Continuar',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 14,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    backgroundColor: _isfileSelected ? Color(0xFF1769FF) :  Color(0xFFDFDFDF),
                    elevation: 0,
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                    );
                  },
                ),

              ],
            ),
          ),
        ),
    );
  }
}
