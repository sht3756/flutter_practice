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
