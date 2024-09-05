// 사용자 정의 Notifier 클래스와 함께 사용되어 상태를 추적하고 변경을 감지
// NotifierProvider 는 changeNotifier 와 StateNotifier 프로바이더를 대체 가능

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

class Session extends Notifier<bool> {
  @override
  bool build() => false; // 초기값을 담당한다.

  void login() { // 메소드 직접적으로 선언함
    state = true; // state 의 값을 변경함으로써 UI의 상태가 변경이 됨
  }

  void logout() {
    state = false;
  }
}

final sessionProvider = NotifierProvider<Session, bool>(() => Session());

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(sessionProvider); // watch : 값이 변할때마다 갱신
    final sessionNotifier = ref.read(sessionProvider.notifier); // read 로 메소드 직접적으로 접근할떄 사용

    return Scaffold(
      appBar: AppBar(
        title: const Text('login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLoggedIn ? '로그인' : '로그아웃',
              style: const TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed:
                  isLoggedIn ? sessionNotifier.logout : sessionNotifier.login,
              child: Text(isLoggedIn ? '로그아웃' : '로그인'),
            ),
          ],
        ),
      ),
    );
  }
}
