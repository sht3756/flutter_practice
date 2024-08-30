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
