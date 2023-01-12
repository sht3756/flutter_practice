import 'package:authentication_study/restaurant/model/restaurant_detail_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  // baseURL = http://$ip/restaurant;
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // http://$ip/restaurant/;
  // @GET("/")
  // paginate();

  // http://$ip/restaurant/:id;
  @GET("/{id}")
  @Headers({
    'accessToken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    // id 변수를 매변 요청할 때마다 넣어줘야하는데, @Path 어노테이션으로 정의해주면 된다.
    @Path() required String id,
  });
}
