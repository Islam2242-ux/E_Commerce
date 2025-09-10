import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/chat_state.dart';
import 'chat_detail_page.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final threads = context.watch<ChatState>().threads;
    return Scaffold(
      appBar: AppBar(title: const Text('Chats')),
      body: ListView.separated(
        itemCount: threads.length,
        separatorBuilder: (_, __) => const Divider(height: 0),
        itemBuilder: (context, i) {
          final t = threads[i];
          return ListTile(
            leading: CircleAvatar(backgroundImage: AssetImage(t.avatar)),
            title: Text(t.name),
            subtitle: t.messages.isNotEmpty ? Text(t.messages.last.text, maxLines: 1, overflow: TextOverflow.ellipsis) : null,
            trailing: t.unread > 0
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(12)),
                    child: Text('${t.unread}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  )
                : null,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => ChatDetailPage(threadId: t.id)));
            },
          );
        },
      ),
    );
  }
}