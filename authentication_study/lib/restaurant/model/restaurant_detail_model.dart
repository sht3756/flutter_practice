import 'package:authentication_study/common/const/data.dart';
import 'package:authentication_study/restaurant/model/restaurant_model.dart';

// "detail": "요청사항에 '리뷰작성' | '리뷰' 남겨주시면 따근한 치즈스틱을 보내 드립니다!!!\n    \n메뉴권과 디지털 금액권 선물 바등신 고객님은 아웃백 어플에서 이제 주문이 가능합니다. 딜리버리 주문하기에서 메뉴주문 하신 후 결제하실때 메뉴권, 디지털 금액권 체크하고 선물받으신 바코드 번호 입력하시면 결제가 됩니다~ 참고해주세요!!\n    \n사나이 대왕 스테이크는 모든 음식을 전자레인지에 1분 데워 드시면 더더더더더욱 맛있게 드실 수 있습니다!",
// "products": [
//   {
//     "id": "eb22739f-18bf-4c5f-bcc1-50cab293096f",
//     "name": "감자칩 스테이크",
//     "detail": "스테끼에는 역시 감자칩이 진리! 겉은 바삭바삭하게 구워지고 속은 촉촉하게 미디엄레어로 구워진 스테이크와함께 소금과 후추가 듬뿍 뿌려진 짭짤한 감자칩을 같이 먹어볼 수 있는 세트메뉴!",
//     "imgUrl": "/img/스테이크/감자칩스테이크.jpg",
//     "price": 10000
//   },
// ]
// 데이터로 오는 것이 RestaurantModel 같은 게 많으니 상속 해주는것이다.
class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaurantProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  // factory 생성자 매핑 자동으로 되게 설정
  factory RestaurantDetailModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return RestaurantDetailModel(
      id: json['id'],
      name: json['name'],
      thumbUrl: 'http://$ip${json['thumbUrl']}',
      tags: List<String>.from(json['tags']),
      priceRange: RestaurantPriceRange.values.firstWhere(
        (e) => e.name == json['priceRange'],
      ),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
      detail: json['detail'],
      products: json['products']
          .map<RestaurantProductModel>(
            (x) => RestaurantProductModel.fromJson(json: x),
          )
          .toList(),
    );
  }
}

//   {
//     "id": "eb22739f-18bf-4c5f-bcc1-50cab293096f",
//     "name": "감자칩 스테이크",
//     "detail": "스테끼에는 역시 감자칩이 진리! 겉은 바삭바삭하게 구워지고 속은 촉촉하게 미디엄레어로 구워진 스테이크와함께 소금과 후추가 듬뿍 뿌려진 짭짤한 감자칩을 같이 먹어볼 수 있는 세트메뉴!",
//     "imgUrl": "/img/스테이크/감자칩스테이크.jpg",
//     "price": 10000
//   },

class RestaurantProductModel {
  final String id;
  final String name;
  final String detail;
  final String imgUrl;
  final int price;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
  });

  // factory 생성자로 자동으로 매핑되게 설정
  factory RestaurantProductModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return RestaurantProductModel(
      id: json['id'],
      name: json['name'],
      detail: json['detail'],
      imgUrl: 'http://$ip${json['imgUrl']}',
      price: json['price'],
    );
  }
}
