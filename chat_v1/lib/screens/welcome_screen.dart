import 'package:chat_v1/widgets/custom_stroked_text.dart';
import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'login_screen.dart';
import '../widgets/custom_orange_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: height * 0.08),

              CustomStrokedText(
                text: "BIENVENIDO",
                fontSize: width * 0.16, // escala con pantalla
                strokeColor: const Color(0xFFFF9500),
                strokeWidth: width * 0.04,
                fillColor: Colors.white,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: height * 0.05),

              CustomOrangeButton(
                text: "INICIAR SESIÓN",
                onPressed: () async {
                  await Future.delayed(const Duration(milliseconds: 150)); // ajusta el tiempo

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                fontSize: width * 0.09,
                width: width * 0.87,
                height: height * 0.12,
              ),

              SizedBox(height: height * 0.02),

              CustomOrangeButton(
                text: "REGISTRARSE",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                },
                fontSize: width * 0.09,
                width: width * 0.87,
                height: height * 0.12,
              ),

              SizedBox(height: height * 0.04),

              Expanded(
                child: Image.asset(
                  'assets/images/cheetah.png',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}