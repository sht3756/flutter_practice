import 'package:authentication_study/common/const/data.dart';
import 'package:authentication_study/user/model/user_model.dart';
import 'package:authentication_study/user/repository/user_me_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// UserModelBase? 를 상속한 클래스는 모두 가능하다, null 도 가능하다.
class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  // 요청할 레포지토리 선언
  final UserMeRepository repository;

  // 스토리지에서 토큰을 먼저 가져온다.
  final FlutterSecureStorage storage;

  UserMeStateNotifier({
    required this.repository,
    required this.storage,
  }) : super(UserModelLoading()) {
    // 내 정보 가져오기(super 생성자에서 바로 실행하는 이유는 현재 가지고 있는 토큰으로 api 응답 받아, 바로 상태에 넣어줄것이다.)

    getMe();
  }

  // 현재 사용자를 가져오는 로직
  Future<void> getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    // refresh , accessToken 둘중 하나라도 없으면, 함수 실행 못하게 하는 조건
    if (refreshToken == null || accessToken == null) {
      // 로그아웃 된 상태라고 알려주는 null
      state = null;
      return;
    }

    final res = await repository.getMe(); // UserModel

    state = res;
  }
}

/*
 getMe 현재 사용자를 가져오는 로직
 1. 어떤 레포지토리에서 가져올지 인스턴스에 required 선언한다.
 2. 토큰을 가져올 스토리지를 인스턴스에 required 선언한다.
 3. 토큰에서 accessToken 과 refreshToken 을 가져온다.
 4. 만약 토큰 둘중 하나라도 없으면 상태에 로그아웃 상태로 넣어준다.
 5. 토큰이 둘다 있으면 api 통신해서 응답받은 값(현재 로그인된 유저의 토큰 id, 이름, 이미지 url) 를 상태에 넣어준다.
*/
