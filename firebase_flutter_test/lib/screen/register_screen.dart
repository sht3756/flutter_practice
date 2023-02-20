import 'package:firebase_flutter_test/layout/default_layout.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        body: Center(
      child: Text('회원가입'),
    ));
  }
}
