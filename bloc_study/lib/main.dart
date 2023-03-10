import 'package:bloc/bloc.dart';
import 'package:bloc_study/app.dart';
import 'package:bloc_study/counter_observer.dart';
import 'package:flutter/material.dart';

void main() {
  // bloc 초기화
  Bloc.observer = const CounterObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterApp(),
    );
  }
}
