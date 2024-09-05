// 변경될 수 있는 간단한 상태를 관리
// 프로바이더의 상태 객체가 변경됨에 따라 UI 가 상태 변경에 반응

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterStateProvider = StateProvider<int>((ref) => 0);

class CounterWidget extends ConsumerWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterStateProvider);

    return ElevatedButton(
        onPressed: () => ref.read(counterStateProvider.notifier).state++,
        child: Text('Value : $counter'));
  }
}
