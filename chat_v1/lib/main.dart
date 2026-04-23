import 'package:chat_v1/data/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'screens/welcome_screen.dart';
import 'providers/llm_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  //await DatabaseHelper.instance.deleteAllTables();
  await DatabaseHelper.instance.database;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LlmProvider()),
        // aquí después puedes agregar:
        // ChangeNotifierProvider(create: (_) => StudentProvider()),
      ],
      child: MaterialApp(
        title: 'Chatbot App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFFFF9500),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFF9500),
          ),
          useMaterial3: true,
          fontFamily: 'sans-serif',
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}