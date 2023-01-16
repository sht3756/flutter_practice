import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/layout/default_layout.dart';
import 'package:riverpod_study/riverpod/future_provider.dart';

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue state = ref.watch(multipleFutureProvider);

    return DefaultLayout(
        title: 'FutureProviderScreen',
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // multipleFutureProvider 의 상태가 변하게 되면,
            // 각각의 파라미터에 해당되는 함수가 실행이 되며, 위젯을 반환할 수 있다.
            state.when(
              // 로딩이 끝나고 데이터가 있을때
              data: (data) {
                return Text(
                  data.toString(),
                  textAlign: TextAlign.center,
                );
              },
              // 에러가 있을때
              error: (err, stack) => Text(err.toString()),
              // 로딩일때
              loading: () => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ));
  }
}
