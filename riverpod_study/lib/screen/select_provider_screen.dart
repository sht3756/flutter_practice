import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/layout/default_layout.dart';
import 'package:riverpod_study/riverpod/select_provider.dart';

class SelectProviderScreen extends ConsumerWidget {
  const SelectProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provider 의 값이 변경되는 지 watch
    // isSpicy 상태값만 변하는것을 확인해서 build함수 실행
    final state = ref.watch(selectProvider.select((value) => value.isSpicy));
    print('build');
    // listen 에도 select 함수 적용
    // hasBought 상태값만을 listen 해서
    ref.listen(
      selectProvider.select((value) => value.hasBought),
      (previous, next) {
        print('next : $next');
      },
    );
    return DefaultLayout(
        title: 'SelectProviderScreen',
        body: Column(
          children: [
            Text(state.toString()),
            ElevatedButton(
                onPressed: () {
                  ref.read(selectProvider.notifier).toggleIsSpicy();
                },
                child: Text('Spicy 토글')),
            ElevatedButton(
                onPressed: () {
                  ref.read(selectProvider.notifier).toggleHasBought();
                },
                child: Text('HasBought 토글')),
          ],
        ));
  }
}
