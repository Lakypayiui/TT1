import 'package:chat_v1/data/database_helper.dart';
import 'package:chat_v1/screens/home_screen.dart';
import 'package:chat_v1/screens/register_screen.dart';
import 'package:chat_v1/services/session_service.dart';
import 'package:chat_v1/widgets/custom_back_button.dart';
import 'package:chat_v1/widgets/custom_stroked_text.dart';
import 'package:chat_v1/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/primary_button.dart';

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
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: CustomBackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: height * 0.03),
              CustomStrokedText(
                text:"INICIA SESIÓN",
                fontSize: width * 0.16, // escala con pantalla
                strokeColor: const Color(0xFFFF9500),
                strokeWidth: width * 0.05, // escala con pantalla
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
              SizedBox(height: height * 0.03),

              CustomTextFormField(
                controller: _passCtrl,
                labelText: "CONTRASEÑA",
                obscureText: true,
                validator: (v) => v?.isEmpty ?? true ? "Campo requerido" : null,
              ),
              SizedBox(height: height * 0.02),

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

              SizedBox(height: height * 0.02),

              PrimaryButton(
                text: "INICIAR SESIÓN",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {

                    final student = await DatabaseHelper.instance
                        .getStudentByEmail(_emailCtrl.text.trim());

                    if (!mounted) return;

                    if (student == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Usuario no encontrado")),
                      );
                      return;
                    }

                    if (student.password != _passCtrl.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Contraseña incorrecta")),
                      );
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Bienvenido ${student.name}")),
                    );

                    await SessionService.saveSession(student.id!);

                    if (!mounted) return;

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  }
                },
                fontSize: width * 0.09,
                width: width * 0.87,
                height: height * 0.12,
              ),

              SizedBox(height: height * 0.03),
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