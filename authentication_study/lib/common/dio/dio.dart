import 'package:authentication_study/common/const/data.dart';
import 'package:authentication_study/common/secure_storage/secure_storage.dart';
import 'package:authentication_study/user/provider/auth_provider.dart';
import 'package:authentication_study/user/provider/user_me_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  // 스토리지 프로바이더를 바라본다.
  // Provider 로 또다른 Provider 를 바라본다.
  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(
    CustomInterceptor(storage: storage, ref: ref),
  );
  return dio;
});

class CustomInterceptor extends Interceptor {
  // 스토리지 안에서 토큰을 가져오기 위해서 선언
  final FlutterSecureStorage storage;

  // 테스트 : 리프레쉬 만료되면 로그아웃 되게 하기 위함, UserMeProvider 의 logout() 함수를 provider 로 불러와서 실행하면 되지않을까 라는 테스트
  final Ref ref;

  CustomInterceptor({
    required this.storage,
    required this.ref,
  });

  // 1) 요청 보낼때
  // 요청이 보내질때마다
  // 만약에 요청의 Header 에 accessToken: true 라는 값이 있다면
  // 실제 토큰을 가져와서 storage 에서 authorization: bearer $token 으로 헤더를 변경하다.

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');

    // header 의 accessToken 이 true 가 온다면?
    if (options.headers['accessToken'] == 'true') {
      // 헤더삭제
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      // 실제 토큰으로 대체
      options.headers.addAll({'authorization': 'Bearer $token'});
    }

    if (options.headers['refreshToken'] == 'true') {
      // 헤더삭제
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      // 실제 토큰으로 대체
      options.headers.addAll({'authorization': 'Bearer $token'});
    }
    return super.onRequest(options, handler);
  }

  // 2) 응답을 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');
    return super.onResponse(response, handler);
  }

  // 3) 에러가 났을때
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // 401 에러가 날때 (status code)
    // 토큰을 재발급 받는 시도를 한다.
    // 토큰이 재발급되면, 다시 새로운 토큰으로 요청을 한다.
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    // refreshToken 이 없으면
    // 당연히 에러를 던진다.
    if (refreshToken == null) {
      // 에러를 던질때는 handler.reject 를 사용한다.
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      try {
        final res = await dio.post(
          'http://$ip/auth/token',
          options: Options(headers: {
            'authorization': 'Bearer $refreshToken',
          }),
        );
        final accessToken = res.data['accessToken'];

        final options = err.requestOptions;

        // 토큰 변경하기
        options.headers.addAll({
          'authorization': 'Bearer $accessToken',
        });

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // 요청 재전송
        final response = await dio.fetch(options);

        return handler.resolve(response);
      } on DioError catch (e) {
        // circular dependency error : 무한 루프
        // 실수
        // 설명 : 서로가 서로를 의존하고 있다. A -> B -> A -> B
        // (userMeProvider(authRepositoryProvider, userMeRepositoryProvider) -> dio -> userMeProvider(authRepositoryProvider, userMeRepositoryProvider))
        // ref.read(userMeProvider.notifier).logout();
        // 해결법
        // authProvider 는 dio 를 의존하고 있지 않다.그냥 ref 만 받고있다.
        ref.read(authProvider.notifier).logout();

        // on DioError : 오직 DioError 만!
        return handler.reject(e);
      }
    }
    return handler.reject(err);
  }
}

// refresh 까지 만료가 된다면, 기존 로직에서 에러가 던져지는데, 로그아웃을 시키고 토큰을 삭제해야한다.
