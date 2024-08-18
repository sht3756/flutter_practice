import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_study/course_1/async_hive_cache/api/api_service.dart';
import 'package:flutter_native_study/course_1/async_hive_cache/data/todo_repository.dart';
import 'package:flutter_native_study/course_1/async_hive_cache/model/todo.dart';
import 'package:flutter_native_study/course_1/async_hive_cache/todo_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoAdapter());

  await Hive.openBox<ToDo>('todoBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'async_hive_cache',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TodoScreen(
        repository: ToDoRepository(
          ApiService(Dio(),
              baseUrl: Platform.isAndroid
                  ? 'http://10.0.2.2:3000'
                  : 'http://localhost:3000',
          ),
          Hive.box<ToDo>('todoBox'),
        ),
      ),
    );
  }
}
