import 'package:chat_v1/screens/home_screen.dart';
import 'package:chat_v1/screens/register_screen.dart';
import 'package:chat_v1/widgets/custom_stroked_text.dart';
import 'package:chat_v1/widgets/custom_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_orange_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFF9500)),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),
              CustomStrokedText(
                text:"INICIA SESIÓN",
                fontSize: 70,
                strokeColor: const Color(0xFFFF9500),
                strokeWidth: 18, 
                fillColor: Colors.white,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),

              CustomTextFormField(
                controller: _emailCtrl,
                labelText: "CORREO ELECTRÓNICO",
                hintText: "ejemplo@email.com",
                validator: (v) {
                  if (v?.isEmpty ?? true) return "Campo requerido";
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v!)) {
                    return "Correo inválido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              CustomTextFormField(
                controller: _passCtrl,
                labelText: "CONTRASEÑA",
                obscureText: true,
                validator: (v) => v?.isEmpty ?? true ? "Campo requerido" : null,
              ),
              const SizedBox(height: 24),

              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    // TODO: pantalla de recuperar contraseña
                  },
                  child: Text(
                    "¿Olvidaste tu contraseña?",
                    style: GoogleFonts.lilitaOne(
                      color: Color(0xFFFF9500),
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              CustomOrangeButton(
                text: "INICIAR SESIÓN",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Login simulado exitoso")),
                    );
                    
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                },
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¿No tienes cuenta? ",
                    style: GoogleFonts.lilitaOne(
                      fontSize: 20,
                      color: Color(0xFF715822), // café
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, // quita espacio extra
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      "Regístrate",
                      style: GoogleFonts.lilitaOne(
                        fontSize: 20,
                        color: Color(0xFFFF9500), // naranja
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}