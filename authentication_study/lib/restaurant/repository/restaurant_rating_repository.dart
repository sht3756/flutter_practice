import 'package:authentication_study/common/const/data.dart';
import 'package:authentication_study/common/dio/dio.dart';
import 'package:authentication_study/common/model/cursor_pagination_model.dart';
import 'package:authentication_study/common/model/pagination_params.dart';
import 'package:authentication_study/common/repository/base_pagination_repository.dart';
import 'package:authentication_study/rating/model/rating_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_rating_repository.g.dart';

final restaurantRatingRepositoryProvider =
    Provider.family<RestaurantRatingRepository, String>((ref, id) {
  final dio = ref.watch(dioProvider);

  return RestaurantRatingRepository(dio,
      baseUrl: 'http://$ip/restaurant/$id/rating');
});

// http://ip/restaurant/:rid/rating
@RestApi()
abstract class RestaurantRatingRepository implements IBasePaginationRepository<RatingModel>{
  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) =
      _RestaurantRatingRepository;

  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<RatingModel>> paginate({
    // 쿼리 파라미터 라고 정의 해주는 @어노테이션
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
