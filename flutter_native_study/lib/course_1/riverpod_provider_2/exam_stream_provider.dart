import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Stream<List<String>> listenToMessages() async* {
  List<String> messages = [];
  int count = 1;

  while (count <= 15) {
    // 15 전까지 스트림을 생성
    await Future.delayed(const Duration(seconds: 1));
    messages.add('Message $count');
    yield List.from(messages); // 현재까지의 메세지 리스트를 복사하여 방출
    count++;
  }
}

final messagesProvider = StreamProvider<List<String>>((ref) {
  return listenToMessages();
});

class MessageScreen extends ConsumerWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageAsyncValue = ref.watch(messagesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: Center(
        child: messageAsyncValue.when(
            data: (messages) => ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(messages[index]),
                  ),
                ),
            error: (error, stackTrace) => Text('Error : $error'),
            loading: () => const CircularProgressIndicator()),
      ),
    );
  }
}
