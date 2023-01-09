import 'dart:convert';
import 'package:authentication_study/common/component/custom_text_form_field.dart';
import 'package:authentication_study/common/const/colors.dart';
import 'package:authentication_study/common/const/data.dart';
import 'package:authentication_study/common/layout/default_layout.dart';
import 'package:authentication_study/common/view/root_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                const SizedBox(height: 16.0),
                _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width / 3 * 2,
                ),
                CustomTextFormField(
                  onChanged: (String value) {
                    username = value;
                  },
                  hitText: '이메일을 입력해주세요.',
                ),
                const SizedBox(height: 16.0),
                CustomTextFormField(
                  onChanged: (String value) {
                    password = value;
                  },
                  hitText: '비밀번호를 입력해주세요.',
                  obscureText: true,
                ),
                ElevatedButton(
                  onPressed: () async {
                    // ID:PW
                    final rawString = '$username:$password';

                    // 일반 스트링을 base64 로 인코딩하는 것!
                    Codec<String, String> stringToBase64 = utf8.fuse(base64);
                    String token = stringToBase64.encode(rawString);

                    final resp = await dio.post('http://$ip/auth/login',
                        options: Options(headers: {
                          'authorization': 'Basic $token',
                        }));

                    final refreshToken = resp.data['refreshToken'];
                    final accessToken = resp.data['accessToken'];

                    await storage.write(
                        key: REFRESH_TOKEN_KEY, value: refreshToken);
                    await storage.write(
                        key: ACCESS_TOKEN_KEY, value: accessToken);

                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => RootTab()));
                  },
                  child: Text('로그인'),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: PRIMARY_COLOR),
                ),
                TextButton(
                  onPressed: () async {},
                  child: Text('회원가입'),
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요! \n오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(fontSize: 16, color: BODY_TEXT_COLOR),
    );
  }
}
