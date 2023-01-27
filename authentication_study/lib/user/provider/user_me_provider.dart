import 'package:authentication_study/common/const/data.dart';
import 'package:authentication_study/common/secure_storage/secure_storage.dart';
import 'package:authentication_study/user/model/user_model.dart';
import 'package:authentication_study/user/repository/auth_repository.dart';
import 'package:authentication_study/user/repository/user_me_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final userMeProvider =
    StateNotifierProvider<UserMeStateNotifier, UserModelBase?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userMeRepository = ref.watch(userMeRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return UserMeStateNotifier(
    authRepository: authRepository,
    repository: userMeRepository,
    storage: storage,
  );
});

// UserModelBase? 를 상속한 클래스는 모두 가능하다, null 도 가능하다.
class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository authRepository;

  // 요청할 레포지토리 선언
  final UserMeRepository repository;

  // 스토리지에서 토큰을 먼저 가져온다.
  final FlutterSecureStorage storage;

  UserMeStateNotifier({
    required this.authRepository,
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

  // 로그인 하는 기능, UserModelBase 타입으로 리턴하는 이유는, 무슨 상태값이 올지 모르기 때문이다.()
  Future<UserModelBase> login({
    required String username,
    required String password,
  }) async {
    // 바로 상태 로딩상태로
    state = UserModelLoading();

    try {
      // 로그인 함수 호출
      final res = await authRepository.login(
        username: username,
        password: password,
      );

      // 스토리지에 저장 : 새로운 토큰을 넣어놔야지 꺼내 쓰니깐!
      await storage.write(key: REFRESH_TOKEN_KEY, value: res.refreshToken);
      await storage.write(key: ACCESS_TOKEN_KEY, value: res.accessToken);

      // 토큰을 발급 받아서 스토리지에 저장해놨으니 토큰에 해당 되는 사용자를 가져와서 기억하기 위함
      // 토큰을 새로 발급 받아도 로그인 여부를 알 수 없다, 로그인한 상태여부를 알기 위해 state 에 넣어줄거다.
      // (만약 서버에서 내 유저정보를 가져올 수 있다면, 서버에서 검증이 되었으니 유효한 토큰인걸로 간주하고 응답값을 state 에 넣어준다.)
      final userRepo = await repository.getMe();

      // 상태에 저장
      state = userRepo;

      // 혹시나 Future 에 통해서 값을 반환해야할 경우를 대비해서 반환!
      return userRepo;
    } catch (e) {
      state = UserModelError(message: '로그인에 실패했습니다.');

      // Future 값으로 반환해주기 위해 Future.value(); return state 와 같다.
      return Future.value(state);
    }
  }

  // 로그아웃 하는 기능
  Future<void> logout() async {
    state = null;
    // 토큰지우기

    // 방법 1) 동시에 지우기 (기능은 같다.), await -> 동시에 끝나고 await 할 수 있다. (각각 await 보단 빠르다.)
    await Future.wait([
      storage.delete(key: REFRESH_TOKEN_KEY),
      storage.delete(key: ACCESS_TOKEN_KEY),
    ]);

    // 방법 2 )비동기로 순서를 지켜서
    // await storage.delete(key: REFRESH_TOKEN_KEY);
    // await storage.delete(key: ACCESS_TOKEN_KEY);
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
