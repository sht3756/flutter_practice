import 'package:authentication_study/common/component/paginateion_list_view.dart';
import 'package:authentication_study/restaurant/component/restaurant_card.dart';
import 'package:authentication_study/restaurant/provider/restaurant_provider.dart';
import 'package:authentication_study/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginationListView(
        provider: restaurantProvider,
        itemBuilder: <RestaurantModel>(_, index, model) {
          // RestaurantModel 이 매핑이 되어 들어오면 RestaurantCard 로 자동으로 매핑되게 설정
          return GestureDetector(
            onTap: () {
              // goRouter 통해서 페이지 이동, 파라미터로 고유 id 값도 넣어주기
              // 방법 1) goNamed() 쓸때
              context.goNamed(
                RestaurantDetailScreen.routeName,
                params: {'rid': model.id},
                // 쿼리 파라미터 모바일에서는 웬만하면 쓰지마라!
                // queryParams: {}
              );
              // 방법 2) go() 쓸때
              // context.go('/restaurant/${model.id}');
            },
            child: RestaurantCard.fromModel(model: model),
          );
        });
  }
}
