import 'package:authentication_study/common/model/login_response.dart';
import 'package:authentication_study/common/model/token_response.dart';
import 'package:authentication_study/common/utils/data_utils.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  // http://$ip/auth
  final String baseUrl;
  final Dio dio;

  AuthRepository({
    required this.baseUrl,
    required this.dio,
  });

  // 로그인 요청하는 로직
  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    // 인코딩
    final serialized = DataUtils.plainToBase64('$username:$password');

    // 로그인 api 통신
    final res = await dio.post(
      '$baseUrl/login',
      options: Options(
        headers: {'authorization': 'Beaer $serialized'},
      ),
    );

    // 로그인 api 응답값 LoginResponse instance 에 매핑
    return LoginResponse.fromJson(res.data);
    // 이를 통해 로그인에 대한 레포지토리를 만들수 있다.
  }

  Future<TokenResponse> token() async {
    // token 리프레쉬 요청하는 api : dio 는 이미 interceptor 를 해놨으니 리프레쉬 토큰을 알아서 등록해줄 것이다.
    final res = await dio.post(
      '$baseUrl/token',
      options: Options(headers: {
        // 원래는 'authorization' : 'Bearer token' 를 넣어야 하지만, accessToken 을 true 로 하면 헤더를 자동으로 변환해주는 기능을 만들었다.
        'refreshToken': 'true',
      }),
    );

    // api 응답값을 TokenResponse 의 인스턴스로 wrapping 을해서 반환을 해줄 것이다.
    return TokenResponse.fromJson(res.data);
  }
}
