import 'package:firebase_flutter_test/layout/default_layout.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        body: Center(
      child: Text('로그인'),
    ));
  }
}
