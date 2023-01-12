import 'package:authentication_study/common/const/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  // 스토리지 안에서 토큰을 가져오기 위해서 선언
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  // 1) 요청 보낼때
  // 요청이 보내질때마다
  // 만약에 요청의 Header 에 accessToken: true 라는 값이 있다면
  // 실제 토큰을 가져와서 storage에서 authorization: bearer $token 으로 헤더를 변경하다.

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
    // TODO: implement onResponse
    return super.onResponse(response, handler);
  }

  // 3) 에러가 났을때
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    return super.onError(err, handler);
  }
}
