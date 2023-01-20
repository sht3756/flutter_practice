import 'package:authentication_study/common/const/data.dart';
import 'package:authentication_study/common/dio/dio.dart';
import 'package:authentication_study/common/model/cursor_pagination_model.dart';
import 'package:authentication_study/common/model/pagination_params.dart';
import 'package:authentication_study/restaurant/model/restaurant_detail_model.dart';
import 'package:authentication_study/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

// repository 도 Provider 안에 넣기!
// 기존의 코드릭팩토링(레스토랑 스크린, 디테일 스크린에 있던 페이지네이션 요청 및 응답 하던 코드를 Provider 안에 로직에 넣어서 UI 단에는 UI 코드만 있게끔 리팩토링함.)
final restaurantRepositoryProvider = Provider<RestaurantRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    final repository =
        RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');
    return repository;
  },
);

@RestApi()
abstract class RestaurantRepository {
  // baseURL = http://$ip/restaurant;
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // http://$ip/restaurant/;
  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<RestaurantModel>> paginate({
    // 쿼리 파라미터 라고 정의 해주는 @어노테이션
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  // http://$ip/restaurant/:id;
  @GET('/{id}')
  @Headers({
    'accessToken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    // id 변수를 매변 요청할 때마다 넣어줘야하는데, @Path 어노테이션으로 정의해주면 된다.
    @Path() required String id,
  });
}
