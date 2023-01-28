import 'package:authentication_study/common/const/data.dart';
import 'package:authentication_study/common/dio/dio.dart';
import 'package:authentication_study/user/model/basket_item_model.dart';
import 'package:authentication_study/user/model/patch_basket_body.dart';
import 'package:authentication_study/user/model/user_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'user_me_repository.g.dart';

final userMeRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);

  return UserMeRepository(dio, baseUrl: 'http://$ip/user/me');
});

// http://$ip/user/me
@RestApi()
abstract class UserMeRepository {
  factory UserMeRepository(Dio dio, {String baseUrl}) = _UserMeRepository;

  // 토큰 기준, 현재 사용자 정보 가져오기
  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<UserModel> getMe();

  // 현재 사용자 장바구니 가져오기
  @GET('/basket')
  @Headers({
    'accessToken': 'true',
  })
  Future<List<BasketItemModel>> getBasket();

  // 현재 사용자 장바구니 업데이트
  @PATCH('/basket')
  @Headers({
    'accessToken': 'true',
  })
  Future<List<BasketItemModel>> patchBasket({
    // body 넣는법!
    @Body() required PatchBasketBody body,
  });
}
