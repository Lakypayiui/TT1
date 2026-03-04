import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:llamadart/llamadart.dart';
import 'dart:io';
class LlmProvider extends ChangeNotifier {
  LlamaEngine? _engine;
  List<Map<String, String>> messages = [];
  bool isLoading = false;
  String status = 'Cargando modelo...';

  Future<String> _copyModelFromAssets() async {
  final data = await rootBundle.load('assets/models/qwen306.gguf');

  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/qwen306.gguf');

  await file.writeAsBytes(data.buffer.asUint8List());

  return file.path;
}
  Future<void> loadModel() async {
  try {
    status = 'Inicializando modelo...';
    notifyListeners();

    _engine = LlamaEngine(LlamaBackend());

    final modelPath = await _copyModelFromAssets();
    await _engine!.loadModel(modelPath);

    status = '¡Modelo listo! Pregúntame algo...';

    messages.add({
  'role': 'system',
  'content': 
    'Actúa como un profesor de secundaria empático y experto en pedagogía. ' +
    'Tu objetivo es explicar conceptos complejos usando analogías cotidianas, un lenguaje claro y una estructura de "andamiaje" (scaffolding). ' +
    'Aplica el método Feynman: simplifica el tema sin perder el rigor académico. ' +
    'Adapta tu tono para ser motivador y cercano, validando siempre el esfuerzo del estudiante. /no_think' 
});

    notifyListeners();
  } catch (e) {
    status = 'Error al cargar modelo: $e';
    notifyListeners();
  }
}

  Future<void> sendMessage(String userInput) async {
  if (userInput.trim().isEmpty || _engine == null) return;

  messages.add({'role': 'user', 'content': userInput});
  isLoading = true;
  notifyListeners();

  String assistantReply = '';
  messages.add({'role': 'assistant', 'content': ''});

  // Tokens que indican fin de respuesta en Llama 2
  const stopTokens = [];

  try {
    await for (final token in _engine!.generate(_buildPrompt())) {
      // Verificar si el token es una señal de parada
      bool shouldStop = false;
      for (final stop in stopTokens) {
        if ((assistantReply + token).contains(stop)) {
          shouldStop = true;
          // Limpiar el stop token del reply final
          assistantReply = (assistantReply + token)
              .split(stop)
              .first
              .trim();
          break;
        }
      }

      if (shouldStop) break;

      assistantReply += token;
      messages.last['content'] = assistantReply;
      notifyListeners();
    }
  } catch (e) {
    messages.last['content'] = 'Error: $e';
  }

  // Actualizar el mensaje final limpio
  messages.last['content'] = assistantReply;
  isLoading = false;
  notifyListeners();
}

  String _buildPrompt() {
  final buffer = StringBuffer();

  buffer.writeln("<|im_start|>system");
  
  final systemMsg = messages.firstWhere(
    (m) => m['role'] == 'system',
    orElse: () => {'content': 'You are a helpful assistant.'},
  );
  buffer.writeln(systemMsg['content']);
  buffer.writeln("<|im_end|>");

  for (final msg in messages.where((m) => m['role'] != 'system')) {
    buffer.writeln("<|im_start|>${msg['role']}");
    buffer.writeln(msg['content']);
    buffer.writeln("<|im_end|>");
  }

  // El modelo sabe que debe responder aquí
  buffer.write("<|im_start|>assistant\n");

  return buffer.toString();
}

  @override
  void dispose() {
    _engine?.dispose();
    super.dispose();
  }
}