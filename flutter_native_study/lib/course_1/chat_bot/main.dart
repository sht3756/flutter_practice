import 'package:flutter/material.dart';
import 'package:flutter_native_study/course_1/chat_bot/page/chat_list_page/chat_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter',
      home: ChatListPage(),
    );
  }
}
