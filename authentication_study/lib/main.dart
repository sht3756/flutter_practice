import 'package:authentication_study/common/component/custom_text_form_field.dart';
import 'package:authentication_study/common/view/splash_screen.dart';
import 'package:authentication_study/user/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: _App(),
    ),
  );
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'NotoSans'),
      home: Scaffold(backgroundColor: Colors.white, body: SplashScreen()),
    );
  }
}
