// Provider 는 가장 기본적인 읽기 전용 상태를 제공하는 프로바이더
// 의존성 주입, 구성 설정, 복잡하지 않은 데이터를 주입하는데 사용됨

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final helloProvider = Provider<String>((_) => 'Hello World');

class HelloWidget extends ConsumerWidget {
  const HelloWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(helloProvider);
    return Center(child: Text(value));
  }
}
