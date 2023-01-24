import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router_study/provider/auth_provider.dart';

void main() {
  runApp(ProviderScope(child: _App()));
}

class _App extends ConsumerWidget {
  _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    // go_router 를 사용하려면 .router 선언
    return MaterialApp.router(
      // 라우터 정보를 전달
      routeInformationProvider: router.routeInformationProvider,
      //URI String 을 상태 및 Go Router 에서 사용할 수 있는 형태로 변환해주는 함수
      routeInformationParser: router.routeInformationParser,
      // 위에서 변경된 값으로 실제 어떤 라우트를 보여줄지 정하는 함수
      routerDelegate: router.routerDelegate,
    );
  }
}
