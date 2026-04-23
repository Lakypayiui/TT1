import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../providers/llm_provider.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/custom_back_button.dart';

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
          backgroundColor: const Color(0xFFFFF8E1),

          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: CustomBackButton(
                onPressed: () => Navigator.pop(context),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),

          body: Column(
            children: [
              /// CHAT LIST
              Expanded(
                child: provider.status != '¡Modelo listo! Pregúntame algo...'
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(height: 12),
                            Text(provider.status),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: provider.messages.length,
                        itemBuilder: (context, index) {
                          final msg = provider.messages[index];

                          if (msg['role'] == 'system') {
                            return const SizedBox.shrink();
                          }

                          final isUser = msg['role'] == 'user';

                          return ChatBubble(
                            text: msg['content'] ?? '',
                            isUser: isUser,
                            senderName: isUser ? null : "Rulio",
                          );
                        },
                      ),
              ),

              /// TYPING INDICATOR
              if (provider.isLoading)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Lottie.asset(
                    'assets/animations/typing.json',
                    width: 60,
                  ),
                ),

              /// INPUT BAR
              ChatInputBar(
                controller: _controller,
                onSend: () {
                  final text = _controller.text.trim();
                  if (text.isEmpty) return;

                  provider.sendMessage(text);
                  _controller.clear();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}