import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_study/layout/default_layout.dart';
import 'package:riverpod_study/riverpod/listen_provider.dart';

class ListenProviderScreen extends ConsumerStatefulWidget {
  const ListenProviderScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ListenProviderScreen> createState() =>
      _ListenProviderScreenState();
}

// TickerProviderStateMixin : TabController 에 vsync 에 this 넣기 위함
class _ListenProviderScreenState extends ConsumerState<ListenProviderScreen>
    with TickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(
      length: 10,
      vsync: this,
      // 초기 인덱스를 listenProvider 로 설정, 그러면 0으로 초기화 안된다.
      // listenProvider 를 autoDispose 했으면 매번 0으로 초기화 된다.
      initialIndex: ref.read(listenProvider),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(listenProvider, (previous, next) {
      // 전의 값과 다음값이 다르면 실행
      if (previous != next) {
        // 탭바 다음으로 이동해라
        controller.animateTo(next);
      }
    });

    return DefaultLayout(
        title: 'ListenProviderScreen',
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: List.generate(
              10,
              (index) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(index.toString()),
                      ElevatedButton(
                        onPressed: () {
                          // state 가 10 이 아닐 떄는 + 1
                          ref
                              .read(listenProvider.notifier)
                              .update((state) => state == 10 ? 10 : state + 1);
                        },
                        child: Text('다음'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // state 가 0 이 아닐 떄는 - 1
                          ref
                              .read(listenProvider.notifier)
                              .update((state) => state == 0 ? 0 : state - 1);
                        },
                        child: Text('이전'),
                      ),
                    ],
                  )),
        ));
  }
}
