import 'package:authentication_study/user/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // watch - 값이 변경될때마다 다시 빌드
  // read - 한번만 일고 값이 변경돼도 다시 빌드하지 않음
  // read 하는 이유: 항상 똑같은 GoRouter 인스턴스를 반환해야하기 때문(하지만 authProvider 는 변경될일이 없음)
  final provider = ref.read(authProvider);

  return GoRouter(
    routes: provider.routes,
    initialLocation: '/splash',
    refreshListenable: provider,
    redirect: provider.redirectLogic,
  );
});
