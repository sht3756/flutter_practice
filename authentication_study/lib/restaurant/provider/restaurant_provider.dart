import 'package:authentication_study/common/model/cursor_pagination_model.dart';
import 'package:authentication_study/common/provider/pagination_provider.dart';
import 'package:authentication_study/restaurant/model/restaurant_model.dart';
import 'package:authentication_study/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

// restaurantProvider 에서 제공해주는 상태에 반응해 그 상태안의 데이터 값을 불러올거다. (이미 기억해놓은 캐싱 데이터를 들고오기위함)
final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);

  if (state is! CursorPagination) {
    // CursorPagination 이 아니라면 이미 데이터가 restaurantProvider 에 없다는 뜻
    return null;
  }
  // firstWhere 문으로 RestaurantModel 의 고유 id 값과 restaurantDetailProvider 의 family 에 파라미터 넣어준 id 값과 같은걸 리턴하겠다.
  // 변경 : firstWhereOrNull 로 값이 없으면 null 로 리턴
  return state.data.firstWhereOrNull((element) => element.id == id);
});

// RestaurantStateNotifier 를 리턴해주는 provider 만들었다.
final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>((ref) {
  // provider 안의 provider 를 가져오는 방법!
  final repository = ref.watch(restaurantRepositoryProvider);
  final notifier = RestaurantStateNotifier(repository: repository);

  return notifier;
});

class RestaurantStateNotifier
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  // 페이지네이션 기능과 디테일페이지를 가져오는 기능을 Provider 안에서 수행하고 data 를 받아오고 super constructor 의 list 에 넣어줄것이다.
  RestaurantStateNotifier({
    required super.repository,
  });

  // 가져오려는 고유 id 값의 디테일 조회하는 함수
  void getDetail({
    required String id,
  }) async {
// 만약에 데이터가 없는 상태라면(CursorPagination 이 아니라면) 데이터를 가져온다.
    if (state is! CursorPagination) {
      await this.paginate();
    }

    // state 가 CursorPagination 이 아닐때 그냥 리턴
    if (state is! CursorPagination) {
      return;
    }

    // 캐스팅
    final pState = state as CursorPagination;

    // 새로 요청한 res : getDetail 함수에 넣어준 파라미터 값으로 찾은 응답값이다.
    final res = await repository.getRestaurantDetail(id: id);


    if (pState.data.where((e) => e.id == id).isEmpty) {
      // 요청 id : 11 이고 현재 캐싱데이터에는 id 가 10 까지 있을때
      // list.where((e) e.id == 10) => 데이터 가 없다고 출력!
      // 데이터가 없을시 그냥 캐시의 마지막에 데이터 추가하는 로직 추가!
      // 존재하지 않는 데이터인 경우
      state = pState.copyWith(data: <RestaurantModel>[
        ...pState.data,
        res,
      ]);
    } else {
      // 존재하는 데이터인 경우 ()
      // 파라미터 로 받은 id 값을 pState 에서 찾은 다음에 res 로 대체를 해줘야한다.
      state = pState.copyWith(
        // pState 의 데이터를 변경해주는 로직(pState.data 를 map 함수를 적용해 id 값이 같다면 새로 요청해온 res 값을 넣어주고, 아니면 기존의 데이터 값을 넣어준다.)
        data: pState.data
            .map<RestaurantModel>(
              (e) => e.id == id ? res : e,
            )
            .toList(),
      );
    }
  }
}
