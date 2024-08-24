import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_study/course_1/bloc_2/pages/step_one.dart';
import 'package:flutter_native_study/course_1/bloc_3/bloc/pw_bloc.dart';

import 'bloc/email_bloc.dart';
import 'bloc/name_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => EmailBloc()),
        BlocProvider(create: (context) => NameBloc()),
        BlocProvider(create: (context) => PwBloc()),
      ],
      child: MaterialApp(
        title: 'Bloc From Validation 예제',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const RegisterPage(),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const StepOne()));
          },
          child: const Text('Start Register'),
        ),
      ),
    );
  }
}
