import 'package:authentication_study/common/model/cursor_pagination_model.dart';
import 'package:authentication_study/common/provider/pagination_provider.dart';
import 'package:authentication_study/rating/model/rating_model.dart';
import 'package:authentication_study/restaurant/repository/restaurant_rating_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 바라볼 Provider 가 family 로 생성했으니 StateNotifierProvider 도 family 로 선언
final restaurantRatingProvider = StateNotifierProvider.family<
    RestaurantRatingStateNotifier, CursorPaginationBase, String>((ref, id) {
  final repo = ref.watch(restaurantRatingRepositoryProvider(id));

  return RestaurantRatingStateNotifier(repository: repo);
});

class RestaurantRatingStateNotifier
    extends PaginationProvider<RatingModel, RestaurantRatingRepository> {
  RestaurantRatingStateNotifier({
    required super.repository,
  });
}
