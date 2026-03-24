import 'package:chat_v1/widgets/custom_stroked_text.dart';
import 'package:flutter/material.dart';
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
              CustomStrokedText(
                text: "BIENVENIDO",
                fontSize: 70,              // puedes bajarlo a 60–65 si se ve muy grande
                strokeColor: const Color(0xFFFF9500),
                strokeWidth: 18,           // 16–22 suele verse bien con Lilita One
                fillColor: Colors.white,
                textAlign: TextAlign.center,
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
                padding: EdgeInsets.zero,
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
                padding: EdgeInsets.zero,
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