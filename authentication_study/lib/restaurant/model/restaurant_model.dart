import 'package:authentication_study/common/const/data.dart';
import 'package:authentication_study/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_model.g.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

@JsonSerializable()
class RestaurantModel {
  final String id;
  final String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
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

  // g.dart 적용하기!
  // 1) json -> 인스턴스를 만드는것
  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  // 2) 인스턴스 -> json 으로 만드는것
  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  // thumbUrl 앞에 http://$ip 를 붙여주기 위해서 static 함수 생성
  // g.dart 파일에도 적용이 되게! @JsonKey
  static pathToUrl(String value) {
    // value 는 thumbUrl 이다.
    return 'http://$ip$value';
  }
}
