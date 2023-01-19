import 'package:authentication_study/restaurant/component/restaurant_card.dart';
import 'package:authentication_study/restaurant/provider/restaurant_provider.dart';
import 'package:authentication_study/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(restaurantProvider);

    // TODO : 임시로 분기처리 작성
    if (data.length == 0) {
      return Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        itemCount: data.length,
        itemBuilder: (_, index) {
          final parseItem = data[index];

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
