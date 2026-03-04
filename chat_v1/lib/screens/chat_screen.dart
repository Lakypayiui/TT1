import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../providers/llm_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<LlmProvider>(context, listen: false);
    provider.loadModel();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LlmProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Mini Chat LLM', style: GoogleFonts.poppins()),
            backgroundColor: Colors.indigoAccent.shade700,
          ),
          body: Column(
            children: [
              Expanded(
                child: provider.status != '¡Modelo listo! Pregúntame algo...'
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(height: 16),
                            Text(provider.status),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: provider.messages.length,
                        itemBuilder: (context, index) {
                          final msg = provider.messages[index];
                          if (msg['role'] == 'system') return const SizedBox.shrink();

                          final isUser = msg['role'] == 'user';

                          return Align(
                            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: isUser ? Colors.indigoAccent.shade400 : Colors.grey.shade800,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: MarkdownBody(
                                data: msg['content'] ?? '',
                                selectable: true,
                                styleSheet: MarkdownStyleSheet(
                                  p: GoogleFonts.poppins(fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              if (provider.isLoading)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Lottie.asset('assets/animations/typing.json', width: 50),
                ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Escribe tu mensaje...',
                          filled: true,
                          fillColor: Colors.grey.shade800,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        ),
                        onSubmitted: (_) => _send(provider),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton.filled(
                      icon: const Icon(Icons.send),
                      onPressed: () => _send(provider),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _send(LlmProvider provider) {
    provider.sendMessage(_controller.text);
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}