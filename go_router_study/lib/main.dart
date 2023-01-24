import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_study/screen/home_screen.dart';

void main() {
  runApp(_App());
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  // router 는 라우팅해주는것
  // route 는 router 안에서 각각의 route 를 얘기하는것
  GoRouter get _router => GoRouter(
    initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (_, state) => HomeScreen(),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    // go_router 를 사용하려면 .router 선언
    return MaterialApp.router(
      // 라우터 정보를 전달
      routeInformationProvider: _router.routeInformationProvider,
      //URI String 을 상태 및 Go Router 에서 사용할 수 있는 형태로 변환해주는 함수
      routeInformationParser: _router.routeInformationParser,
      // 위에서 변경된 값으로 실제 어떤 라우트를 보여줄지 정하는 함수
      routerDelegate: _router.routerDelegate,
    );
  }
}
