import 'package:flutter/material.dart';
import 'package:servifix_flutter/api/dto/get_technical_response_by_account.dart';
import 'package:servifix_flutter/api/dto/get_user_response_by_account.dart';
import 'package:servifix_flutter/api/service/technicalService.dart';
import 'package:servifix_flutter/api/service/userService.dart';
import 'package:servifix_flutter/views/register1.dart';
import 'package:servifix_flutter/api/service/authservice.dart';
import 'package:servifix_flutter/views/success.dart';
import 'package:provider/provider.dart';
import 'package:servifix_flutter/api/provider/AuthModel.dart';
import 'package:servifix_flutter/views/tech_profile.dart';
import 'package:servifix_flutter/views/user_profile.dart';


TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LogIn extends StatelessWidget {

  void clearFields() {
    emailController.clear();
    passwordController.clear();
  }

  void _showResetPasswordSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  color: Colors.grey[300],
                  margin: EdgeInsets.only(bottom: 16),
                ),
              ),
              Text(
                'Cambiar contraseña',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Ingresa una nueva contraseña para acceder a tu cuenta.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Nueva contraseña',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Repetir contraseña',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showUpdatedPasswordSheet(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.grey, minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Text('Continuar'),
              ),
              SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showVerificationCodeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  color: Colors.grey[300],
                  margin: EdgeInsets.only(bottom: 16),
                ),
              ),
              Text(
                'Ingresa el código',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Ingresa el código de 4 dígitos enviado a tu correo electrónico.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 24),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Reenviar código',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showResetPasswordSheet(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.grey, minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Text('Continuar'),
              ),
              SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showForgotPasswordSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  height: 4,
                  width: 40,
                  color: Colors.grey[300],
                  margin: const EdgeInsets.only(bottom: 16),
                ),
              ),
              const Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ingresa tu correo electrónico para el proceso de verificación. Te enviaremos un código de 4 dígitos.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showVerificationCodeSheet(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.grey, minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text('Continuar'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _showUpdatedPasswordSheet(BuildContext context){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context){
          return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 4,
                      width: 40,
                      color: Colors.grey[300],
                      margin: const EdgeInsets.only(bottom: 16),
                    ),
                  ),
                  Image(
                    image: AssetImage('lib/assets/tools.png'),
                    width: 70,
                    height: 70,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Contraseña actualizada',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Su contraseña se ha actualizado exitosamente',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.grey, minimumSize: Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text('Iniciar Sesion'),
                  ),
                  SizedBox(height: 16),
                ],
              ),
          );
        },
    );
  }

  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(64.0),
            child: Column(
              children: [
                Image(
                  image: AssetImage('lib/assets/tools.png'),
                  width: 70,
                  height: 70,
                ),
                SizedBox(height: 24),
                Text(
                  'Bienvenido a ServiFix',
                  style: TextStyle(
                    color: Color(0xFF747474),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Ingresa a tu cuenta',
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 24),
                TextField(
                  controller: emailController,
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
                    labelText: 'Correo electrónico',
                    labelStyle: TextStyle(color: Color(0xFFA0A0A0)),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: passwordController,
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
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(color: Color(0xFFA0A0A0)),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final loginResponse = await AuthService().login(emailController.text, passwordController.text);
                      final token = loginResponse.token;
                      final id = loginResponse.id;

                      print('Token: $token');
                      print('Id: $id');

                      if (token.isNotEmpty) {
                        ClientService clienteService = ClientService();
                        TechnicalService tecnicoService = TechnicalService();
                        GetUserResponseByAccount? _cliente;
                        GetTechnicalResponseByAccount? _tecnico;

                        try {
                          GetUserResponseByAccount cliente =
                          await clienteService.getUserByAccountId(id, token);
                          _cliente = cliente;
                          _tecnico = null;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserProfileScreen(token: token, id: id, cliente: cliente)),
                          );
                        } catch (e) {
                          print('Error al obtener el cliente: $e');
                        }

                        if (_cliente == null) {
                          try {
                            GetTechnicalResponseByAccount tecnico =
                            await tecnicoService.getTechnicianByAccountId(id, token);
                            _tecnico = tecnico;
                            _cliente = null;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TechnicalProfileScreen(token: token, id: id, technical: tecnico)),
                            );
                          } catch (e) {
                            print('Error al obtener el técnico: $e');
                          }
                        }
                        clearFields();
                      }
                    } catch (e) {
                      print('Error de inicio de sesión: $e');
                    }
                  },
                  child: const Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 14,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    backgroundColor: Color(0xFF1769FF),
                    elevation: 0,
                  ),
                ),
                SizedBox(height: 16),
                TextButton(
                  child: Text(
                    '¿Olvidaste tu contraseña?',
                    style: TextStyle(
                      color: Color(0xFF67A1FF),
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () => _showForgotPasswordSheet(context),
                ),
                SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿No tienes una cuenta?',
                      style: TextStyle(
                        color: Color(0xFF4D4D4D),
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'Regístrate',
                        style: TextStyle(
                          color: Color(0xFF67A1FF),
                          fontSize: 14,
                        ),
                      ),
                      onPressed: () {
                        clearFields();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register1()),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}