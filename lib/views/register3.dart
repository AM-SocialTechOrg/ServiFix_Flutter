import 'package:flutter/material.dart';
import 'package:servifix_flutter/views/login.dart';
import 'package:servifix_flutter/views/successful_registration.dart';

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
                onPressed: () {
                  String originalDateTime = widget.birthday.toString();
                  String dateWithoutTime = originalDateTime.substring(0, 10);
                  int _role = 0;

                  if(widget.user == 'client') {
                    _role = 1;
                  } else {
                    _role = 2;
                  }

                  try
                 {
                    final registerResponse = AuthService().register(
                      widget.name,
                      widget.lastname,
                      widget.gender,
                      dateWithoutTime,
                      widget.email,
                      widget.password,
                        _role);
                    if (registerResponse != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SuccessfulRegistration(
                            name: widget.name,
                            lastname: widget.lastname,
                            email: widget.email,
                            user: widget.user
                           )),
                      );
                    }
                  } catch (e) {
                    print('Error de registro: $e');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                    );
                  }

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
