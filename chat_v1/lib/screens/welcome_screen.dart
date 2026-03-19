import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'register_screen.dart';
import 'login_screen.dart';
import '../widgets/custom_orange_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Stack(
                children: [
                  // Contorno
                  Text(
                    'BIENVENIDO',
                    style: GoogleFonts.lilitaOne(
                      fontSize: 60,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 20
                        ..color = Color(0xFFFF9500),
                    ),
                  ),
                  // Relleno
                  Text(
                    'BIENVENIDO',
                    style: GoogleFonts.lilitaOne(
                      fontSize: 60,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              CustomOrangeButton(
                text: "INICIAR SESIÓN",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                fontSize: 36,
                width: 342,
                height: 106,
              ),
              const SizedBox(height: 20),
              CustomOrangeButton(
                text: "REGISTRARSE",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                },
                fontSize: 36,
                width: 342,
                height: 106,
              ),
              const Spacer(flex: 2),
              Image.asset(
                'assets/images/cheetah.png',
                height: 450,
              ),
            ],
          ),
        ),
      ),
    );
  }
}