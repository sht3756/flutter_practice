// 비동기 작업의 결과를 관리하기 위해 사용
// 비동기 연산의 캐싱과 결과 반환
// 비동기 작업의 에러와 로딩 상태 처리
// 여러 비동기 값 결합

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<String> fetchUser() async {
  await Future.delayed(const Duration(seconds: 2));
  return 'Harry';
}

final userProvider = FutureProvider<String>((ref) async {
  return fetchUser();
});


class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userFuture = ref.watch(userProvider);
    return userFuture.when(data: (data) => Text('User : $data'), error: (error, stackTrace) => Text('Error : $error'), loading: () => const CircularProgressIndicator());
  }
}

