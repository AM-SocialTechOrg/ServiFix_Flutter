import 'package:flutter/material.dart';
import 'package:servifix_flutter/views/register1.dart';
import 'package:servifix_flutter/api/service/authservice.dart';
import 'package:servifix_flutter/views/success.dart';
import 'package:provider/provider.dart';
import 'package:servifix_flutter/api/provider/AuthModel.dart';
import 'package:servifix_flutter/views/user_publication.dart';



TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LogIn extends StatelessWidget {

  void clearFields() {
    emailController.clear();
    passwordController.clear();
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
                      if (token.isNotEmpty) {
                        clearFields();
                        Provider.of<Authmodel>(context, listen: false).setToken(token);
                        Navigator.push(
                          context,
                          //MaterialPageRoute(builder: (context) => Success(token: token)),
                          // user_publication
                          MaterialPageRoute(builder: (context) => ProfileScreen()),
                        );
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
                  onPressed: () {
                    // Add code here
                  },
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