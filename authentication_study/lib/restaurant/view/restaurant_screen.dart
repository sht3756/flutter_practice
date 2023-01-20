import 'package:authentication_study/common/model/cursor_pagination_model.dart';
import 'package:authentication_study/restaurant/component/restaurant_card.dart';
import 'package:authentication_study/restaurant/provider/restaurant_provider.dart';
import 'package:authentication_study/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  // 현재 위치를 알기 위한 스크롤 컨트롤러
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(scrollListener);
  }

  void scrollListener() {
    // 현재 스클롤 위치가 최대 길이 만큼 거의 도달했을떄 새로운데이터 요청
    // 최대 길이 -300 보다 현재 스크롤 위치가 크면 실행
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.read(restaurantProvider.notifier).paginate(
            fetchMore: true,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(restaurantProvider);

    // 완전 처음 랜더링할때
    if (data is CursorPaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 에러날 때
    if (data is CursorPaginationError) {
      return Center(
        child: Text(data.message),
      );
    }

    // CursorPagination
    // CursorPaginationFetchingMore
    // CursorPaginationRefetching

    // 캐스팅
    final cp = data as CursorPagination;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        controller: controller,
        itemCount: cp.data.length,
        itemBuilder: (_, index) {
          final parseItem = cp.data[index];

          // RestaurantModel 이 매핑이 되어 들어오면 RestaurantCard 로 자동으로 매핑되게 설정
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => RestaurantDetailScreen(
                  id: parseItem.id,
                ),
              ));
            },
            child: RestaurantCard.fromModel(model: parseItem),
          );
        },
        separatorBuilder: (_, index) {
          return SizedBox(height: 16.0);
        },
      ),
    );
  }
}
