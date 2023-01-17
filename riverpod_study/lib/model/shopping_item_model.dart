class ShoppingItemModel {
  // 이름
  final String name;

  // 개수
  final int quantity;

  // 구매했는지
  final bool hasBought;

// 매운지
  final bool isSpicy;

  ShoppingItemModel({
    required this.name,
    required this.quantity,
    required this.hasBought,
    required this.isSpicy,
  });

  ShoppingItemModel copyWith({
    String? name,
    int? quantity,
    bool? hasBought,
    bool? isSpicy,
  }) {
    // 파라미터로 입력된값들만 새로 저장되고, 없으면 기존 값 유지
    return ShoppingItemModel(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      hasBought: hasBought ?? this.hasBought,
      isSpicy: isSpicy ?? this.isSpicy,
    );
  }
}
