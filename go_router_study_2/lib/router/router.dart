import 'package:go_router/go_router.dart';
import 'package:go_router_study_2/constants.dart';
import 'package:go_router_study_2/login_state.dart';
import 'package:go_router_study_2/ui/create_account.dart';
import 'package:go_router_study_2/ui/details.dart';
import 'package:go_router_study_2/ui/error_page.dart';
import 'package:go_router_study_2/ui/home_screen.dart';
import 'package:go_router_study_2/ui/login.dart';
import 'package:go_router_study_2/ui/more_info.dart';
import 'package:go_router_study_2/ui/payment.dart';
import 'package:go_router_study_2/ui/personal_info.dart';
import 'package:go_router_study_2/ui/signin_info.dart';

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
          path: '/:tab',
          name: rootRouteName,
          builder: (context, state) {
            final tab = state.params['tab'];
            return HomeScreen(tab: tab ?? '');
          },
          routes: [
            GoRoute(
              name: profilePersonalRouteName,
              path: 'profile-personal',
              builder: (context, state) {
                return const PersonalInfo();
              },
            ),
            GoRoute(
              name: shopDetailsRouteName,
              path: 'details/:item',
              builder: (context, state) {
                return Details(description: state.params['item']!);
              },
            ),
            GoRoute(
              name: profilePaymentRouteName,
              path: 'payment',
              builder: (context, state) {
                return const Payment();
              },
            ),
            GoRoute(
              name: profileSigninInfoRouteName,
              path: 'signin-info',
              builder: (context, state) {
                return const SigninInfo();
              },
            ),
            GoRoute(
              name: profileMoreInfoRouteName,
              path: 'more-info',
              builder: (context, state) {
                return const MoreInfo();
              },
            ),
          ]),
    ],
    redirect: (context, state) {
      // 현재 우리가 보고있는 페이지 확인
      // 현재 로그인 상태 어떤지 확인
      final loggedIn = loginState.loggedIn;
      // state.subloc : 현재 위치해 있는 쿼리파라미터를 리턴한다.
      final inAuthPages = state.subloc.contains(loginRouteName) ||
          state.subloc.contains(createAccountRouteName);

      // inAuth && true => go to home
      if (inAuthPages && loggedIn) return '/shop';
      // noInAuth && false => go to loginPage
      if (!inAuthPages && !loggedIn) return '/login';
    },
    // 초기값
    initialLocation: '/login',
    // loginState 상태를 지켜본다.
    refreshListenable: loginState,
    // 개발시 디버그하기, 앱출시에는 false 로 변경해야한다.
    debugLogDiagnostics: true,
  );
}
