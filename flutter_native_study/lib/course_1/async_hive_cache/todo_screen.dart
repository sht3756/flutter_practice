import 'package:flutter/material.dart';
import 'package:flutter_native_study/course_1/async_hive_cache/data/todo_repository.dart';

class TodoScreen extends StatefulWidget {
  final ToDoRepository repository;

  const TodoScreen({super.key, required this.repository});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
