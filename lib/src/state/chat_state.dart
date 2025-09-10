import 'package:flutter/material.dart';

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime time;

  ChatMessage({required this.text, required this.isMe, DateTime? time})
      : time = time ?? DateTime.now();
}

class ChatThread {
  final String id;
  final String name;
  final String avatar;
  final List<ChatMessage> messages;
  final int unread;

  ChatThread({
    required this.id,
    required this.name,
    required this.avatar,
    this.messages = const [],
    this.unread = 0,
  });

  ChatThread copyWith({List<ChatMessage>? messages, int? unread}) => ChatThread(
        id: id,
        name: name,
        avatar: avatar,
        messages: messages ?? this.messages,
        unread: unread ?? this.unread,
      );
}

class ChatState extends ChangeNotifier {
  final Map<String, ChatThread> _threads = {
    '1': ChatThread(
      id: '1',
      name: 'BlueSea Support',
      avatar: 'assets/images/avatar_1.png',
      messages: [
        ChatMessage(text: 'Halo! Ada yang bisa kami bantu?', isMe: false),
      ],
      unread: 1,
    ),
    '2': ChatThread(
      id: '2',
      name: 'Seller Outfit Pro',
      avatar: 'assets/images/avatar_2.png',
      messages: [
        ChatMessage(text: 'Stok ukuran M tersedia ya!', isMe: false),
      ],
      unread: 0,
    ),
    '3': ChatThread(
      id: '3',
      name: 'Food Express',
      avatar: 'assets/images/avatar_3.png',
      messages: [
        ChatMessage(text: 'Pesanan Anda sedang diproses.', isMe: false),
      ],
      unread: 2,
    ),
  };

  List<ChatThread> get threads => _threads.values.toList();

  ChatThread? getThread(String id) => _threads[id];

  void sendMessage(String threadId, String text) {
    final t = _threads[threadId];
    if (t == null) return;
    final updated = t.copyWith(messages: [
      ...t.messages,
      ChatMessage(text: text, isMe: true),
    ]);
    _threads[threadId] = updated;
    notifyListeners();
  }

  void receiveMessage(String threadId, String text) {
    final t = _threads[threadId];
    if (t == null) return;
    final updated = t.copyWith(
      messages: [...t.messages, ChatMessage(text: text, isMe: false)],
      unread: t.unread + 1,
    );
    _threads[threadId] = updated;
    notifyListeners();
  }

  void markRead(String threadId) {
    final t = _threads[threadId];
    if (t == null) return;
    _threads[threadId] = t.copyWith(unread: 0);
    notifyListeners();
  }
}
