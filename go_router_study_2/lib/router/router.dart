import 'package:go_router/go_router.dart';
import 'package:go_router_study_2/constants.dart';
import 'package:go_router_study_2/login_state.dart';
import 'package:go_router_study_2/ui/create_account.dart';
import 'package:go_router_study_2/ui/error_page.dart';
import 'package:go_router_study_2/ui/home_screen.dart';
import 'package:go_router_study_2/ui/login.dart';

class MyRouter {
  final LoginState loginState;

  MyRouter(this.loginState);

  late final router = GoRouter(
    errorBuilder: (context, state) {
      return ErrorPage(
        error: state.error,
      );
    },
    // 각페이지의 루트 포함
    routes: [
      GoRoute(
        // 경로
        path: '/login',
        // 경로 이름 : 겹치면 안된다.
        name: loginRouteName,
        // 경로 전달해줄 곳
        builder: (context, state) {
          return const Login();
        },
      ),
      GoRoute(
        path: '/create-account',
        name: createAccountRouteName,
        builder: (context, state) {
          return const CreateAccount();
        },
      ),
      GoRoute(
        path: '/',
        name: rootRouteName,
        builder: (context, state) {
          return HomeScreen(tab: 'shopping');
        },
      ),
    ],
    // 초기값
    initialLocation: '/login',
    // loginState 상태를 지켜본다.
    refreshListenable: loginState,
    // 개발시 디버그하기, 앱출시에는 false 로 변경해야한다.
    debugLogDiagnostics: true,
  );
}
