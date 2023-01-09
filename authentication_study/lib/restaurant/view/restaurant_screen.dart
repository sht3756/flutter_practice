import 'package:authentication_study/common/const/data.dart';
import 'package:authentication_study/restaurant/component/restaurant_card.dart';
import 'package:authentication_study/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  Future<List> paginateRestaurant() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final res = await dio.get(
      'http://$ip/restaurant',
      options: Options(headers: {
        'authorization': 'Bearer $accessToken',
      }),
    );

    return res.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<List>(
          future: paginateRestaurant(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return ListView.separated(
                itemBuilder: (_, index) {
                  final item = snapshot.data![index];
                  final parseItem = RestaurantModel.fromJson(json: item);

                  return RestaurantCard(
                    image: Image.network(
                      parseItem.thumbUrl,
                      fit: BoxFit.cover,
                    ),
                    name: parseItem.name,
                    // <dynamic>으로 오는걸 List<String>형태로 바꾼다.
                    tags: parseItem.tags,
                    ratingsCount: parseItem.ratingsCount,
                    deliveryTime: parseItem.deliveryTime,
                    deliveryFee: parseItem.deliveryFee,
                    ratings: parseItem.ratings,
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
