import 'package:json_annotation/json_annotation.dart';

part 'patch_basket_body.g.dart';

@JsonSerializable()
class PatchBasketBody {
  final List<PatchBasketBodyBasket> basket;

  PatchBasketBody({
    required this.basket,
  });

  Map<String, dynamic> toJson() => _$PatchBasketBodyToJson(this);
}

@JsonSerializable()
class PatchBasketBodyBasket {
  final String productId;
  final int count;

  PatchBasketBodyBasket({
    required this.productId,
    required this.count,
  });

  factory PatchBasketBodyBasket.fromJson(Map<String, dynamic> json)
  => _$PatchBasketBodyBasketFromJson(json);

  Map<String, dynamic> toJson() => _$PatchBasketBodyBasketToJson(this);
}

/*
PATCH
Request body

1. PatchBasketBody 구조
{
  "basket": [
      PatchBasketBodyBasket
  ]
}


2. PatchBasketBodyBasket 구조
{
  "productId": "1952a209-7c26-4f50-bc65-086f6e64dbbd",
  "count": 10
}
*/
