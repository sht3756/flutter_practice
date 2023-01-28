import 'package:json_annotation/json_annotation.dart';

part 'patch_basket_body.g.dart';

@JsonSerializable()
class PatchBasketBody {
  final String productId;
  final int count;

  PatchBasketBody({
    required this.productId,
    required this.count,
  });

  Map<String, dynamic> toJson() => _$PatchBasketBodyToJson(this);
}


/*
PATCH
Request body

{
  "basket": [
    {
      "productId": "1952a209-7c26-4f50-bc65-086f6e64dbbd",
      "count": 10
    }
  ]
}
*/