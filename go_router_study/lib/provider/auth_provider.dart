import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_study/model/user_model.dart';
import 'package:go_router_study/screen/1_screen.dart';
import 'package:go_router_study/screen/2_screen.dart';
import 'package:go_router_study/screen/3_screen.dart';
import 'package:go_router_study/screen/error_screen.dart';
import 'package:go_router_study/screen/home_screen.dart';
import 'package:go_router_study/screen/login_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // 일반 provider 처럼 선언해서 접근!
  final authStateProvider = AuthNotifier(ref: ref);

  return GoRouter(
    initialLocation: '/',
    // 에러페이지 등록
    errorBuilder: (context, state) {
      // navigation 간에 생긴 에러는 state 에 담겨온다.
      return ErrorScreen(error: state.error.toString());
    },
    // redirect
    // redirect 는 네비게이션 이동시 매번 실행이 되는데, refreshListenable 에 넣은 값도 추가해준다.
    redirect: authStateProvider._redirectLogic,
    // refresh (refreshListenable 의 값이 변경이 될 때마다 redirect 가 실행된다)

    refreshListenable: authStateProvider,
    routes: authStateProvider._routes,
  );
});

// refresh 로직을 작성할 것이다.
class AuthNotifier extends ChangeNotifier {
  final Ref ref;

  AuthNotifier({
    required this.ref,
  }) {
    ref.listen<UserModel?>(userProvider, (previous, next) {
      if (previous != next) {
        // 기존값과 새로운 값이 다를때(상태가 변할때!)
        // 위젯들이 리빌드해주는 기능(ChangeNotifier 를 바라보는 모든 위젯들이 build 된다.)
        notifyListeners();
      }
    });
  }

  // 반환값
  String? _redirectLogic(_, GoRouterState state,
      ) {
    // UserModel 의 인스턴스 or null
    final user = ref.read(userProvider);
    // 로그인을 하려는 상태인지(로그인 페이지에 있다면)
    final loggingIn = state.location == '/login';

    // 유저 정보가 없다 - 비로그인 한 상태 이다.
    if(user == null) {
      // 유저정보 없고 로그인 하려는 중이 아니라면 로그인페이지로 이동 아니면 null
      return loggingIn ? null :'/login';
    }

    // 유저 정보 있다 - 로그인 한 상태
    if(loggingIn) {
      // 홈으로 이동
      return '/';
    }

  }

  // Route 로직
  List<GoRoute> get _routes => [
        GoRoute(
          path: '/',
          builder: (_, state) => HomeScreen(),
          // 중첩(nesting)
          routes: [
            GoRoute(
              path: 'one',
              builder: (_, state) => OneScreen(),
            ),
            GoRoute(path: 'two', builder: (_, state) => TwoScreen(), routes: [
              GoRoute(
                path: 'three',
                name: ThreeScreen.routename,
                builder: (_, state) => ThreeScreen(),
              ),
            ]),
          ],
        ),
        GoRoute(
          path: '/login',
          builder: (_, state) => LoginScreen(),
        ),
      ];
}

// provider 로 만들기(어디서도 접근가능하게)
final userProvider = StateNotifierProvider<UserStateNotifier, UserModel?>(
  (ref) => UserStateNotifier(),
);

// 유저의 상태를 관리할거다.(UserModel? : 비로그인시에는 null 값 넣을것이기 때문)
class UserStateNotifier extends StateNotifier<UserModel?> {
  UserStateNotifier() : super(null);

  // 로그인 상태면 UserModel 인스턴스 상태로 넣어주기
  login({
    required String name,
  }) {
    state = UserModel(name: name);
  }

  // 비로그인 상태면 null 상태로 넣어주기
  logout() {
    state = null;
  }
}
