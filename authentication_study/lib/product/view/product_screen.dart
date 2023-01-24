import 'package:authentication_study/common/component/paginateion_list_view.dart';
import 'package:authentication_study/product/component/product_card.dart';
import 'package:authentication_study/product/model/product_model.dart';
import 'package:authentication_study/product/provider/product_provider.dart';
import 'package:authentication_study/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => RestaurantDetailScreen(
                  // ProductModel 에 restaurant 가 있으니깐! 접근가능!
                  id: model.restaurant.id,
                ),
              ),
            );
          },
          child: ProductCard.fromProductModel(model: model),
        );
      },
    );
  }
}
