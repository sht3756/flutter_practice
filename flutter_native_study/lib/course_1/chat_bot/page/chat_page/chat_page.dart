import 'package:flutter/material.dart';
import 'package:flutter_native_study/course_1/chat_bot/hive_model/chat_item_model.dart';

import 'widgets/chat_input.dart';

class ChatPage extends StatelessWidget {
  final ChatItemModel chatItem;

  const ChatPage({super.key, required this.chatItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatRoom'),
      ),
      body: ChatInput(
        onSend: (String message) {},
        isLoading: false,
      ),
    );
  }
}
