import 'package:flutter/material.dart';
import 'package:flutter_native_study/course_1/async_hive_cache/data/todo_repository.dart';
import 'package:flutter_native_study/course_1/async_hive_cache/model/todo.dart';

class TodoScreen extends StatefulWidget {
  final ToDoRepository repository;

  const TodoScreen({super.key, required this.repository});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  void _addNewTodo() async {
    final text = await _showAddToDoDialog();
    if (text != null && text.isNotEmpty) {
      widget.repository.createToDo(text);
    }
  }

  Future<String?> _showAddToDoDialog() {
    TextEditingController controller = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New ToDo'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter ToDo text here'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _toggleToDoStatus(ToDo todo) {
    widget.repository.updateToDo(todo.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await widget.repository.refreshToDos();
        },
        child: StreamBuilder<List<ToDo>>(
          stream: widget.repository.toDosStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                !snapshot.hasData) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error : ${snapshot.error}');
            } else if (snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No ToDo items');
            }
            return ListView(
              children: snapshot.data!
                  .map((toDo) => ToDoItem(
                        toDo: toDo,
                        onChecked: () => _toggleToDoStatus(toDo),
                      ))
                  .toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTodo,
        tooltip: 'Add ToDo',
      ),
    );
  }
}

class ToDoItem extends StatelessWidget {
  final ToDo toDo;
  final VoidCallback onChecked;

  const ToDoItem({super.key, required this.toDo, required this.onChecked});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(toDo.text),
      leading: Checkbox(
        value: toDo.done,
        onChanged: (bool? value) => onChecked(),
      ),
    );
  }
}
