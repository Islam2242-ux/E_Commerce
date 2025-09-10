import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/chat_state.dart';
import '../theme/app_theme.dart';

class ChatDetailPage extends StatefulWidget {
  final String threadId;
  const ChatDetailPage({super.key, required this.threadId});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatState>().markRead(widget.threadId);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChatState>();
    final thread = state.getThread(widget.threadId);
    if (thread == null) {
      return const Scaffold(body: Center(child: Text('Thread tidak ditemukan')));
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage(thread.avatar)),
            const SizedBox(width: 8),
            Text(thread.name),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: thread.messages.length,
              itemBuilder: (context, i) {
                final m = thread.messages[i];
                final align = m.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
                final bg = m.isMe ? AppTheme.lightBlue : Colors.white;
                final fg = m.isMe ? Colors.black : Colors.black87;
                final radius = m.isMe
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      );
                return Column(
                  crossAxisAlignment: align,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(color: bg, borderRadius: radius, boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
                      ]),
                      child: Text(m.text, style: TextStyle(color: fg)),
                    ),
                  ],
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _ctrl,
                      decoration: const InputDecoration(hintText: 'Tulis pesan...'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    child: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        final text = _ctrl.text.trim();
                        if (text.isEmpty) return;
                        context.read<ChatState>().sendMessage(widget.threadId, text);
                        _ctrl.clear();
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}