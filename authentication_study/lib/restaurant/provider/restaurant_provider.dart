import 'package:authentication_study/common/model/cursor_pagination_model.dart';
import 'package:authentication_study/restaurant/model/restaurant_model.dart';
import 'package:authentication_study/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// RestaurantStateNotifier 를 리턴해주는 provider 만들었다.
final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, List<RestaurantModel>>(
        (ref) {
  // provider 안의 provider 를 가져오는 방법!
  final repository = ref.watch(restaurantRepositoryProvider);
  final notifier = RestaurantStateNotifier(repository: repository);

  return notifier;
});

class RestaurantStateNotifier extends StateNotifier<CursorPagination> {
  final RestaurantRepository repository;

  // 페이지네이션 기능과 디테일페이지를 가져오는 기능을 Provider 안에서 수행하고 data 를 받아오고 super constructor 의 list 에 넣어줄것이다.
  RestaurantStateNotifier({
    required this.repository,
  }) : super(CursorPagination(meta: meta, data: data)) {
    paginate();
  }

  // repository 를 정상적으로 받았다는 가정하에 paginate 함수 안에서 페이지네이션을 진행하고 값을 반환받는 것이 아니라
  // 상태 안에다 응답받은 리스트로 된 RestaurantModel 을 집어넣을것이다.
  // 위젯에서는 상태를 바라보고있다가 상태가 변화하면 화면에 새로운값으로 랜더링 해줄것이다.
  paginate() async {
    final res = await repository.paginate();

    state = res.data;
  }
}
