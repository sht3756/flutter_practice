import 'package:authentication_study/common/component/custom_text_form_field.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(_App());
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                onChanged: (String value) {},
                hitText: '이메일을 입력해주세요.',
              ),
              CustomTextFormField(
                onChanged: (String value) {},
                hitText: '비밀번호를 입력해주세요.',
                obscureText: true,
              ),
            ],
          )),
    );
  }
}
