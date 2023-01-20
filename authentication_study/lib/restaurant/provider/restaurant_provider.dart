import 'package:authentication_study/common/model/cursor_pagination_model.dart';
import 'package:authentication_study/restaurant/model/restaurant_model.dart';
import 'package:authentication_study/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// RestaurantStateNotifier 를 리턴해주는 provider 만들었다.
final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>((ref) {
  // provider 안의 provider 를 가져오는 방법!
  final repository = ref.watch(restaurantRepositoryProvider);
  final notifier = RestaurantStateNotifier(repository: repository);

  return notifier;
});

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;

  // 페이지네이션 기능과 디테일페이지를 가져오는 기능을 Provider 안에서 수행하고 data 를 받아오고 super constructor 의 list 에 넣어줄것이다.
  RestaurantStateNotifier({
    required this.repository,
  }) : super(CursorPaginationLoading()) {
    paginate();
  }

  // repository 를 정상적으로 받았다는 가정하에 paginate 함수 안에서 페이지네이션을 진행하고 값을 반환받는 것이 아니라
  // 상태 안에다 응답받은 리스트로 된 RestaurantModel 을 집어넣을것이다.
  // 위젯에서는 상태를 바라보고있다가 상태가 변화하면 화면에 새로운값으로 랜더링 해줄것이다.
  paginate({
    int fetchCount = 20,
    // 추가로 데이터 가져오기여부, true : 추가로 가져오기, false : 새로고침(현재상태를 덮어씌움)
    bool fetchMore = false,
    // ture : CursorPaginationLoading()
    bool forceRefetch = false,
}) async {
    // 5가지
    // State 상태
    // 1) CursorPagination - 정상적으로 데이터가 있는 상태
    // 2) CursorPaginationLoading - 데이터가 로딩중인 상태 (현재 캐시 없음)
    // 3) CursorPaginationError - 에러가 있는 상태
    // 4) CursorPaginationRefetching - 첫번째 페이지부터 다시 데이터를 가져올때
    // 5) CursorPaginationFetchMore - 추가 데이터를 paginate 해오라는 요청을 받았을때

    // final res = await repository.paginate();
    //
    // state = res;
  }
}
