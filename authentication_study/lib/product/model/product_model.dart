import 'package:authentication_study/common/model/model_with_id.dart';
import 'package:authentication_study/common/utils/data_utils.dart';
import 'package:authentication_study/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

// 페이징모델을 만들었으니 implements 해준다.
@JsonSerializable()
class ProductModel implements IModelWithId {
  final String id;

  // 상품 이름
  final String name;

  // 상품 상세정보
  final String detail;

  // 상품 이미지
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String imgUrl;

  // 상품 가격
  final int price;

  // 레스토랑 정보
  final RestaurantModel restaurant;

  ProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
    required this.restaurant,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
