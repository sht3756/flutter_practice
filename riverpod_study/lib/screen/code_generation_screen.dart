import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/layout/default_layout.dart';
import 'package:riverpod_study/riverpod/code_generation_provider.dart';

class CodeGenerationScreen extends ConsumerWidget {
  const CodeGenerationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state1 = ref.watch(gStateProvider);
    // AutoDisposeProvider 로 만들어짐, 그렇기 때문에 자동을 종료된다.
    final state2 = ref.watch(gStateFutureProvider);
    // FutureProvider 로 만들어짐, 그렇기 때문에 캐싱데이터 들고온다.
    final state3 = ref.watch(gStateFuture2Provider);

    return DefaultLayout(
      title: 'CodeGenerationScreen',
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text('State1 : $state1'),
            state2.when(
              // 로딩이 끝나고 데이터가 있을때
              data: (data) {
                return Text(
                  'State2 : $data',
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
            state3.when(
              // 로딩이 끝나고 데이터가 있을때
              data: (data) {
                return Text(
                  'State2 : $data',
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
        ),
      ),
    );
  }
}
