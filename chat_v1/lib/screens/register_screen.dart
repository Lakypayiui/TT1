import 'package:chat_v1/screens/login_screen.dart';
import 'package:chat_v1/widgets/custom_choice_chip.dart';
import 'package:chat_v1/widgets/custom_stroked_text.dart';
import 'package:chat_v1/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_orange_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  String? _selectedGrade;

  bool get _passwordsMatch => _passCtrl.text == _confirmCtrl.text;

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
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              CustomStrokedText(
                text: "REGISTRO",
                fontSize: 70,
                strokeColor: const Color(0xFFFF9500),
                strokeWidth: 18, 
                fillColor: Colors.white,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              CustomTextFormField(
                controller: _nameCtrl,
                labelText: "Nombre completo",
                hintText: "Tu nombre aquí",
                textCapitalization: TextCapitalization.words,
                validator: (v) => v?.trim().isEmpty ?? true ? "Campo requerido" : null,
              ),
              const SizedBox(height: 20),

              CustomTextFormField(
                controller: _emailCtrl,
                labelText: "Correo electrónico",
                hintText: "ejemplo@email.com",
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) return "Campo requerido";
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) return "Correo inválido";
                  return null;
                },
              ),
              const SizedBox(height: 20),

              Text(
                "GRADO", 
                style: GoogleFonts.lilitaOne(
                  fontWeight: FontWeight.normal,
                  color: const Color(0xFF715822),
                  fontSize: 14,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: ["1°", "2°", "3°"].map((grado) {
                  return Expanded(
                    child: CustomChoiceChip(
                      text: grado,
                      isSelected: _selectedGrade == grado,
                      onTap: () {
                        setState(() => _selectedGrade =
                            _selectedGrade == grado ? null : grado);
                      },
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              CustomTextFormField(
                controller: _passCtrl,
                labelText: "Contraseña",
                obscureText: true,
                validator: (v) => (v?.length ?? 0) < 6 ? "Mínimo 6 caracteres" : null,
              ),
              const SizedBox(height: 20),

              CustomTextFormField(
                controller: _confirmCtrl,
                labelText: "Confirmar",
                obscureText: true,
                validator: (v) {
                  if (v == null || v.isEmpty) return "Campo requerido";
                  if (v != _passCtrl.text) return "Las contraseñas no coinciden";
                  return null;
                },
              ),

              if (!_passwordsMatch && _confirmCtrl.text.isNotEmpty) ...[
                const SizedBox(height: 8),
                const Text(
                  "¡LAS CONTRASEÑAS NO COINCIDEN!",
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],

              const SizedBox(height: 40),

              CustomOrangeButton(
                text: "REGISTRARSE",
                onPressed: () {
                  if (_formKey.currentState!.validate() && _selectedGrade != null) {
                    // Aquí iría la lógica de registro (por ahora solo pop)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("¡Registro simulado exitoso!")),
                    );
                    Navigator.pop(context);
                  } else if (_selectedGrade == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Selecciona un grado")),
                    );
                  }
                },
              ),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¿Ya tienes cuenta? ",
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
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      "Inicia sesión",
                      style: GoogleFonts.lilitaOne(
                        fontSize: 20,
                        color: Color(0xFFFF9500), // naranja
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }
}