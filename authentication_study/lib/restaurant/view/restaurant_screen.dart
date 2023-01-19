import 'package:authentication_study/common/const/data.dart';
import 'package:authentication_study/restaurant/component/restaurant_card.dart';
import 'package:authentication_study/common/dio/dio.dart';
import 'package:authentication_study/restaurant/model/restaurant_model.dart';
import 'package:authentication_study/restaurant/repository/restaurant_repository.dart';
import 'package:authentication_study/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  Future<List<RestaurantModel>> paginateRestaurant(WidgetRef ref) async {
    final dio = ref.watch(dioProvider);

    final res =
        await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant')
            .paginate();

    return res.data;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<List<RestaurantModel>>(
          future: paginateRestaurant(ref),
          builder: (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.separated(
                itemBuilder: (_, index) {
                  final parseItem = snapshot.data![index];

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
                itemCount: snapshot.data!.length);
          },
        ),
      )),
    );
  }
}
