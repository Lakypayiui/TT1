import 'package:flutter/material.dart';
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
              const Text(
                "REGISTRO",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF9500),
                ),
              ),
              const SizedBox(height: 40),

              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: "NOMBRE COMPLETO",
                  hintText: "Tu nombre aquí",
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (v) => v?.trim().isEmpty ?? true ? "Campo requerido" : null,
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(
                  labelText: "CORREO ELECTRÓNICO",
                  hintText: "ejemplo@email.com",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) return "Campo requerido";
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                    return "Correo inválido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              const Text("GRADO", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                children: ["1°", "2°", "3°"].map((grado) {
                  return ChoiceChip(
                    label: Text(grado),
                    selected: _selectedGrade == grado,
                    selectedColor: const Color(0xFFFF9500),
                    backgroundColor: Colors.grey.shade200,
                    labelStyle: TextStyle(
                      color: _selectedGrade == grado ? Colors.white : Colors.black87,
                    ),
                    onSelected: (selected) {
                      setState(() => _selectedGrade = selected ? grado : null);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              TextFormField(
                controller: _passCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "CONTRASEÑA",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v?.length ?? 0) < 6 ? "Mínimo 6 caracteres" : null,
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _confirmCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "CONFIRMAR",
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return "Campo requerido";
                  if (!_passwordsMatch) return "Las contraseñas no coinciden";
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
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "¿Ya tienes cuenta? Inicia sesión",
                  style: TextStyle(color: Color(0xFFFF9500)),
                ),
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