import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/layout/default_layout.dart';
import 'package:riverpod_study/reverpod/state_provider_screen.dart';
import 'package:riverpod_study/screen/state_notifier_provider.dart';

class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 특정 provider 를 바라 보고있다가 변경이 되는것을 감지한다.

    final provider = ref.watch(numberProvider);
    return DefaultLayout(
        title: 'StateProviderScreen',
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(provider.toString()),
              ElevatedButton(
                onPressed: () {
                  // update 할때, read 로 변화된 것을 읽고 .notifier 로 변화를 준다.
                  ref
                      .read(numberProvider.notifier)
                      .update((state) => state + 1);
                },
                child: Text('UP'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(numberProvider.notifier).state =
                      ref.read(numberProvider.notifier).state - 1;
                },
                child: Text('Down'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => _NextScreen(),
                    ),
                  );
                },
                child: Text('NextScreen'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => StateNotifierProviderScreen(),
                    ),
                  );
                },
                child: Text('StateNotifierProviderScreen'),
              ),
            ],
          ),
        ));
  }
}

class _NextScreen extends ConsumerWidget {
  const _NextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(numberProvider);

    return DefaultLayout(
        title: 'StateProviderScreen',
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(provider.toString()),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(numberProvider.notifier)
                      .update((state) => state + 1);
                },
                child: Text('UP'),
              )
            ],
          ),
        ));
  }
}
