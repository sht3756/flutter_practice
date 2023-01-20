import 'package:authentication_study/common/model/cursor_pagination_model.dart';
import 'package:authentication_study/common/model/pagination_params.dart';
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
  void paginate({
    int fetchCount = 20,
    // 추가로 데이터 가져오기여부, true : 추가로 가져오기, false : 새로고침(현재상태를 덮어씌움)
    bool fetchMore = false,
    // ture : CursorPaginationLoading()
    bool forceRefetch = false,
  }) async {
    try {
      // 5가지
      // State 상태
      // 1) CursorPagination - 정상적으로 데이터가 있는 상태
      // 2) CursorPaginationLoading - 데이터가 로딩중인 상태 (현재 캐시 없음)
      // 3) CursorPaginationError - 에러가 있는 상태
      // 4) CursorPaginationRefetching - 첫번째 페이지부터 다시 데이터를 가져올때
      // 5) CursorPaginationFetchMore - 추가 데이터를 paginate 해오라는 요청을 받았을때

      // 바로 반환하는 상황
      // 1) hasMore = false (기존 상태에서 이미 다음 데이터가 없다는 값을 들고있다면?)
      // 2) 로딩중 - fetchMore : true 일때
      //    fetchMore 이 아닐때 - 새로고침의 의도가 있을 수 있다.
      if (state is CursorPagination && !forceRefetch) {
        // pagination 을 하고 이미 데이터를 가지고있을때, 강제 새로고침이라면  body 실행
        // state 를 캐스팅 할수 있는 이유는 이미 if 문에 CursorPagination 이라고 타입 비교를 했기때문
        final pState = state as CursorPagination;

        if (!pState.meta.hasMore) {
          return;
        }
      }

      // 첫랜더링 로딩 시 (기존 데이터 없음)
      final isLoading = state is CursorPaginationLoading;
      // 새로고침 로딩시 (기존 데이터 있음)
      final isRefeching = state is CursorPaginationRefetching;
      // 데이터 추가 요청시 (기존 데이터 있음)
      final isFetchingMore = state is CursorPaginationFetchingMore;

      if (fetchMore && (isLoading || isRefeching || isFetchingMore)) {
        return;
      }

      // PaginationParams 생성
      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
      );

      // fetchMore : 데이터를 추가로 요청하는 상황
      if (fetchMore) {
        // 캐스팅을 할 수 있는 이유는 데이터를 추가로 요청하는 상황에서는 CursorPagination 을 extends 또는 인스턴스라는 상황을 확신하기 때문
        final pState = state as CursorPagination;

        // state CursorPaginationFetchingMore 로 변경 : 현재 상태와 데이터는 유지하면서 클래스만 바꾸는 것이다.
        state = CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data,
        );

        // after 는 무조건 넣어야한다. 다음 데이터를 추가 요청할때 어떤 데이터를 마지막으로 불러와야하는지 알아야하기 때문
        // 데이터를 추가로 요청하는 상황이니, paginationParams 의 after 변경을 해줬다.(after 의 값의 다음값을 가져와서 data 뒤에 붙여줘야하니깐!)
        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
      } else {
        // state 가 CursorPaginationFetchingMore 이 아닐때,
        // 데이터가 있는 상활일때 기존 데이터 유지한채 Fetch (Api 요청) 진행
        // 데이터를 처음 부터 가져오는 것이니 위의 if 문처럼 paginationParams 를 변경할 필요도 없다!
        if (state is CursorPagination && !forceRefetch) {
          // CursorPagination 으로 캐스팅
          final pState = state as CursorPagination;

          state = CursorPaginationRefetching(
            meta: pState.meta,
            data: pState.data,
          );
        } else {
          // 데이터를 유지할 필요가 없을때
          state = CursorPaginationLoading();
        }
      }

      /*
     if(fetchMore 가 true 일때) {
      state 에 현재 상태와 데이터는 그대로 주면서 클래스로 CursorPaginationFetchingMore 할것이다라고 알려주고있다.
      ...
     }
     UI 에서는 현재 클래스가 CursorPaginationFetchingMore 이면 로딩화면 을 보여주는 식으로 작업 가능하다.


    */
      // 로딩이 돌아가는 순간 요청을 해야한다. (응답값이 맨 처음 페이지를 요청했을때의 값이다.)
      final res = await repository.paginate(
        paginationParams: paginationParams,
      );

      if (state is CursorPaginationFetchingMore) {
        // 현재 상태 캐스팅 해주고,
        final pState = state as CursorPaginationFetchingMore;

        // 응답이 다 온 다음(로딩이 다 끝난 상태)에는 상태를 다시 캐스팅해줘야한다.
        // paginate 함수는 이미 <CursorPagination<RestaurantModel>> 인스턴스를 자동으로 반환해준다.
        state = res.copyWith(
            // meta 는 그대로 유지하고 data 만 변경할거다.
            // data 는 기존 + 요청받은 새로운 데이터 를 할것이기 때문!
            data: [
              ...pState.data,
              ...res.data,
            ]);
      } else {
        // CursorPaginationLoading 이거나 CursorPaginationRefetching 일때
        // 맨 처음 페이지 응답값을 넣어주면된다. (paginationParams 에 after 값을 넣은 값이 아니기 때문이다.)
        state = res;
      }
    } catch (e) {
      state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }
}
