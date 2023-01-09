import 'package:authentication_study/common/const/data.dart';
import 'package:authentication_study/restaurant/component/restaurant_card.dart';
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
                  return RestaurantCard(
                    image: Image.network(
                      'http://$ip${item['thumbUrl']}',
                      fit: BoxFit.cover,
                    ),
                    name:item['name'],
                    // <dynamic>으로 오는걸 List<String>형태로 바꾼다.
                    tags: List<String>.from(item['tags']),
                    // tags: ['떡볶이', '치즈', '매운맛'],
                    ratingsCount: item['ratingsCount'],
                    deliveryTime: item['deliveryTime'],
                    deliveryFee: item['deliveryFee'],
                    ratings: item['ratings'],
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
