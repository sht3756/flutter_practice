import 'package:authentication_study/common/view/root_tab.dart';
import 'package:authentication_study/common/view/splash_screen.dart';
import 'package:authentication_study/restaurant/view/restaurant_detail_screen.dart';
import 'package:authentication_study/user/model/user_model.dart';
import 'package:authentication_study/user/provider/user_me_provider.dart';
import 'package:authentication_study/user/view/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// provider 선언
final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    // 상태 알수 있다.(로딩, 로그인, 로그아웃)
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      // userMeProvider 가 상태가 변경이 될때
      if (previous != next) {
        // 알려주는 내장 함수
        notifyListeners();
      }
    });
  }

  // 라우트 등록 : 웹표준 (서버 구조랑 같게 했다.)
  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (_, __) => RootTab(),
          routes: [
            // 서버 path 랑 같게 명명, 라우팅을 할때 rid 를 입력해줄 수 있다.
            GoRoute(
              path: 'restaurant/:rid',
              name: RestaurantDetailScreen.routeName,
              builder: (_, state) => RestaurantDetailScreen(
                id: state.params['rid']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (_, __) => SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (_, __) => LoginScreen(),
        ),
      ];

  // redirect 로직
  // splash screen : 토큰 존재여부에따라 로그인 스크린 or 홈스크린으로 보낼지 확인 과정 필요
  String? redirectLogic(_, GoRouterState state) {
    // 유저 상태
    final UserModelBase? user = ref.read(userMeProvider);
    // 로그인 시도 상태 : 유저의 현재 페이지의 위치가 '/login' 인경우 true 아님 false
    final loginIn = state.location == '/login';

    // 로그아웃된 상태이고, 유저의 로그인 시도 상태가 true 라면 null, false 라면 '/login' 페이지로 이동!
    // 왜냐면 이 앱은 비 로그인 상태에서는 볼수 없는 상태이니 로그 아웃된상태에서 어떠한것도 볼수 없다. 무조건 로그인 페이지로
    if (user == null) {
      return loginIn ? null : '/login';
    }

    // UserModel
    // 로그인된 상태이고, 로그인 중이거나 현재 위치가 SplashScreen 이면 홈으로 이동
    if (user is UserModel) {
      return loginIn || state.location == '/splash' ? '/' : null;
    }

    // UserModelError
    // 에러 상태이고, 로그인 시도상태가 아닐때는 login 페이지로 , 아닐때는 그대로 유지
    if (user is UserModelError) {
      return !loginIn ? '/login' : null;
    }

    // 나머지 경우는 원래 가려던 곳으로 가라
    return null;
  }

// refresh
}
