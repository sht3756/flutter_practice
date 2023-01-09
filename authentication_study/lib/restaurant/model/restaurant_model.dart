import 'package:authentication_study/common/const/data.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

class RestaurantModel {
  final String id;
  final String name;
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  // 인스턴스화할때 매개변수 다 넣을 수 있게 만듬
  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  // factory constructor 사용
  factory RestaurantModel.fromJson({required Map<String, dynamic> json}) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      thumbUrl: 'http://$ip${json['thumbUrl']}',
      tags: List<String>.from(json['tags']),
      // enum 값을 매핑
      priceRange: RestaurantPriceRange.values.firstWhere(
            (e) => e.name == json['priceRange'],
      ),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
    );
  }
}
