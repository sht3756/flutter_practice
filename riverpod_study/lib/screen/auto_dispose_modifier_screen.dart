import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/layout/default_layout.dart';
import 'package:riverpod_study/riverpod/auto_dispose_modifier_provider.dart';

class AutoDisposeModifierScreen extends ConsumerWidget {
  const AutoDisposeModifierScreen({Key? key}) : super(key: key);
// 메모리에 캐싱 된것을 자동으로 삭제해준다.

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(autoDisposeModifierProvider);

    return DefaultLayout(
        title: 'AutoDisposeModifierScreen',
        body: Center(
          child: state.when(
            data: (data) => Text(data.toString()),
            error: (err, stack) => Text(err.toString()),
            loading: () => CircularProgressIndicator(),
          ),
        ));
  }
}
