import 'package:flutter/material.dart';
import 'package:flutter_board/data/repository/board_repository_impl.dart';
import 'package:flutter_board/data/source/remote/board_api.dart';
import 'package:flutter_board/presenetation/home_screen.dart';
import 'package:flutter_board/presenetation/home_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider.value(
      value: HomeViewModel(BoardRepositoryImpl(BoardApi())),
      child: const MyApp()));
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
      home: const HomeScreen(),
    );
  }
}
