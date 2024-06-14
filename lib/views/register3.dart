import 'package:flutter/material.dart';
import 'package:servifix_flutter/api/dto/cliente_response.dart';
import 'package:servifix_flutter/api/dto/login_response.dart';
import 'package:servifix_flutter/api/dto/technical_request.dart';
import 'package:servifix_flutter/api/dto/user_request.dart';
import 'package:servifix_flutter/api/service/userService.dart';
import 'package:servifix_flutter/api/service/technicalService.dart';
import 'package:servifix_flutter/views/login.dart';
import 'package:servifix_flutter/views/register1.dart';
import 'package:servifix_flutter/views/successful_registration.dart';

import '../api/service/accountservice.dart';
import '../api/service/authservice.dart';

TextEditingController timeController = TextEditingController();
TextEditingController experienceController = TextEditingController();

class Register3 extends StatefulWidget {
  final String name;
  final String lastname;
  final String gender;
  final DateTime birthday;
  final String dni;
  final String email;
  final String password;
  final String user;
  final String phone;

  const Register3({
    Key? key,
    required this.name,
    required this.lastname,
    required this.gender,
    required this.birthday,
    required this.dni,
    required this.email,
    required this.password,
    required this.user,
    required this.phone,
  }) : super(key: key);

  @override
  State<Register3> createState() => _Register3State();
}

class _Register3State extends State<Register3> {

  bool _isformEmpty = true;
  String _selectedJob = "technician";
  String _selectedTime = "years";

  void isFormEmpty() {
    setState(() {
      _isformEmpty = timeController.text.isEmpty;
    });
  }

  void dropDownChangedJob(String? selectedJob) {
    setState(() {
      _selectedJob = selectedJob ?? 'technician';
    });
  }

  void dropDownChangedTime(String? selectedTime) {
    setState(() {
      _selectedTime =  selectedTime ?? 'years';
    });
  }

  clearFields() {
    timeController.clear();
    experienceController.clear();
  }

  Future<void> _registerUser(BuildContext context) async {
    String originalDateTime = widget.birthday.toString();
    String dateWithoutTime = originalDateTime.substring(0, 10);
    int _role = (widget.user == 'client') ? 1 : 2;

    try {
      final registerResponse = await AuthService().register(
        widget.name,
        widget.lastname,
        widget.gender,
        dateWithoutTime,
        widget.email,
        widget.password,
        _role,
      );

      if (registerResponse != null) {
        final loginResponse = await _loginUser(widget.email, widget.password);

        if (loginResponse != null && loginResponse.token != null && loginResponse.id != null) {
          String token = loginResponse.token!;
          int id = loginResponse.id!;
          await _createAccount(context, dateWithoutTime, _role, token, id);
        } else {
          print('No se pudo recuperar el token después del registro');
        }
      }
    } catch (e) {
      print('Error de registro: $e');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LogIn()),
      );
    }
  }

  Future<LoginResponse?> _loginUser(String email, String password) async {
    try {
      final loginResponse = await AuthService().login(email, password);
      return loginResponse;
    } catch (e) {
      print('Error de inicio de sesión: $e');
      return null;
    }
  }

  Future<void> _createTechnical(BuildContext context, String token, int accountId) async {

    print('crear técnico');
    String job =  (_selectedJob == 'technician') ? 'Técnico' : (_selectedJob == 'plumber') ? 'Gasfitero' : (_selectedJob == 'electrician') ? 'Electricista' : (_selectedJob == 'locksmith') ? 'Cerrajero' : 'Pintor';
    String time = (_selectedTime == 'years') ? 'años' : 'meses';

    final technicalRequest = TechnicalRequest(
      policeRecords: widget.name + '_' + widget.lastname + '_records.pdf',
      skills: experienceController.value.text,
      experience: job + ' por ' + timeController.value.text + ' ' + time,
      number: widget.phone,
      description: 'No hay una descripción',
      accountId: accountId,
    );

    print('Request: ' + technicalRequest.toString());

    try {
      final technicalResponse = await TechnicalService().createTechnical(technicalRequest, token);

      if (technicalResponse != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessfulRegistration(
              name: widget.name,
              lastname: widget.lastname,
              email: widget.email,
              user: widget.user,
            ),
          ),
        );
      }
    } catch (e) {
      print('Error al crear técnico: $e');
    }
  }

  Future<void> _createAccount(BuildContext context, String dateWithoutTime, int role, String token, int id) async {
    try {
      await _createTechnical(context, token, id);

    } catch (e) {
      print('Error al crear la cuenta: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    isFormEmpty();

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
                '¡Estás a un paso de ser parte de Servifix!',
                style: TextStyle(
                  color: Color(0xFF1769FF),
                  fontSize: 14,
                ),
              ),

              SizedBox(height: 16),

              Text('¿Cuál es tu área de experiencia?',
                style: TextStyle(
                  color: Color(0xFF4D4D4D),
                  fontSize: 14,
                ),
              ),

              SizedBox(height: 8),

              Container(
                width: 264,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Color(0xFFF4F4F4), width: 1.0),
                ),
                child: DropdownButton<String>(
                  value: _selectedJob,
                  items: const <DropdownMenuItem<String>>[
                    DropdownMenuItem<String>(
                      value: 'technician',
                      child: Text('Técnico'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'plumber',
                      child: Text('Gasfitero'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'electrician',
                      child: Text('Electricista'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'locksmith',
                      child: Text('Cerrajero'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'painter',
                      child: Text('Pintor'),
                    ),
                  ],
                  onChanged: dropDownChangedJob,
                  style: TextStyle(
                    color: Color(0xFF4D4D4D),
                    fontSize: 14,
                  ),
                  underline: Container(),
                  itemHeight: 48,
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 130.0),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 24,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),

              Text('Ingresa tu periodo de experiencia',
                style: TextStyle(
                  color: Color(0xFF4D4D4D),
                  fontSize: 14,
                ),
              ),

              SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: timeController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Color(0xFFF4F4F4), width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1769FF), width: 1.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        labelText: '0',
                        labelStyle: TextStyle(color: Color(0xFFA0A0A0)),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      onChanged: (value) {
                        isFormEmpty();
                      },
                    ),
                  ),

                  SizedBox(width: 24),

                  Container(
                    width: 152,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Color(0xFFF4F4F4), width: 1.0),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedTime,
                      items: const <DropdownMenuItem<String>>[
                        DropdownMenuItem<String>(
                          value: 'years',
                          child: Text('años'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'months',
                          child: Text('meses'),
                        ),
                      ],
                      onChanged: dropDownChangedTime,
                      style: TextStyle(
                        color: Color(0xFF4D4D4D),
                        fontSize: 14,
                      ),
                      underline: Container(),
                      itemHeight: 48,
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),

              Center(
                child: Text('Puedes añadir una breve descripción sobre tu experiencia:',
                  style: TextStyle(
                    color: Color(0xFF4D4D4D),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 8),

              TextField(
                controller: experienceController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Descripción',
                  hintStyle: TextStyle(
                    color: Color(0xFFA0A0A0),
                    fontSize: 14,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Color(0xFFF4F4F4), width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF1769FF), width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Add internal padding

                ),
              ),

              SizedBox(height: 24),

              ElevatedButton(
                onPressed: _isformEmpty ? null : () => _registerUser(context),
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
                  backgroundColor: _isformEmpty ? Color(0xFFDFDFDF) :  Color(0xFF1769FF),
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
                    MaterialPageRoute(builder: (context) => LogIn(),
                    ),
                  );
                },
              ),


            ],
          ),
        ),
      )
    );
  }
}
