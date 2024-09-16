import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  final Function(String message) onSend;
  final bool isLoading;

  const ChatInput({super.key, required this.onSend, required this.isLoading});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      widget.onSend(_controller.text);
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Type a message ...'),
          ),
          widget.isLoading
              ? Container(
                  margin: const EdgeInsets.all(8.0),
                  width: 24.0,
                  height: 24.0,
                  child: const CircularProgressIndicator(),
                )
              : IconButton(onPressed: _sendMessage, icon: const Icon(Icons.send)),
        ],
      ),
    );
  }
}
