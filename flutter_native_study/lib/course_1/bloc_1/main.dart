import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_study/course_1/bloc_1/bloc/stopwatch_bloc.dart';

import 'stopwatch_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StopwatchBloc>(
        create: (BuildContext context) => StopwatchBloc(),
        child: const MaterialApp(home: StopWatchScreen()));
  }
}


