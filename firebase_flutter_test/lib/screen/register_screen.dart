import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_test/layout/default_layout.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
                labelText: '아이디',
                hintText: '아이디를 입력해주세요',
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black,
                  width: 15,
                ))),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
                labelText: '비밀번호',
                hintText: '비밀번호를 입력해주세요',
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black,
                  width: 0.5,
                ))),
            keyboardType: TextInputType.visiblePassword,
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  print('userCredential ${userCredential.toString()}');
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'email-already-in-use') {
                    customSnackBar(
                        context, const Text('email-already-in-use!!'));
                  } else if (e.code == 'invalid-email') {
                    customSnackBar(context, const Text('invalid-email!!'));
                  } else if (e.code == 'operation-not-allowed') {
                    customSnackBar(
                        context, const Text('operation-not-allowed!!'));
                  } else if (e.code == 'weak-password') {
                    customSnackBar(context, const Text('weak-password!!'));
                  }
                }
              },
              child: const Text('회원가입'))
        ],
      ),
    ));
  }

  // 스낵바
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar(
      BuildContext context, Widget childText) {
    final customSnackBar = SnackBar(
      content: childText,
      duration: const Duration(seconds: 3),
    );
    return ScaffoldMessenger.of(context).showSnackBar(customSnackBar);
  }
}
