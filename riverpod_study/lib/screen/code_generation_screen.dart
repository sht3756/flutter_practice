import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/layout/default_layout.dart';
import 'package:riverpod_study/riverpod/code_generation_provider.dart';

class CodeGenerationScreen extends ConsumerWidget {
  const CodeGenerationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build');
    final state1 = ref.watch(gStateProvider);
    // AutoDisposeProvider 로 만들어짐, 그렇기 때문에 자동을 종료된다.
    final state2 = ref.watch(gStateFutureProvider);
    // FutureProvider 로 만들어짐, 그렇기 때문에 캐싱데이터 들고온다.
    final state3 = ref.watch(gStateFuture2Provider);
    // @ 어노테이션을 통해서 .family 파라미터 전달받기
    final state4 = ref.watch(gStateMultiplyProvider(number1: 100, number2: 20));
    // StateNotifierProvider 코드제너레이션으로 만들기
    // final state5 = ref.watch(gStateNotifierProvider);

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
            Text('State4 : $state4'),
            Consumer(
              // state5 를 Consumer 위젯을 사용해서 build 함수 재실행 안되게 적용
              builder: (context, ref, child) {
                final state5 = ref.watch(gStateNotifierProvider);

                return Row(
                  children: [
                    Text('State5 : $state5'),
                    if (child != null) child,
                  ],
                );
              },
              child: Text('Hello'),
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      ref.read(gStateNotifierProvider.notifier).increment();
                    },
                    child: Text('State5 증가')),
                ElevatedButton(
                    onPressed: () {
                      ref.read(gStateNotifierProvider.notifier).decrement();
                    },
                    child: Text('State5 감소')),
              ],
            ),
            //invalidate() 함수 : 상태값을 초기화 시키겠다. Disposed 된다.
            ElevatedButton(
              onPressed: () {
                ref.invalidate(gStateNotifierProvider);
              },
              child: Text('Invalidate'),
            ),
          ],
        ),
      ),
    );
  }
}
