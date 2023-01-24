import 'package:authentication_study/common/model/cursor_pagination_model.dart';
import 'package:authentication_study/common/provider/pagination_provider.dart';
import 'package:authentication_study/product/model/product_model.dart';
import 'package:authentication_study/product/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productProvider =StateNotifierProvider<ProductStateNotifier, CursorPaginationBase>((ref) {
  final repo = ref.watch(productRepositoryProvider);

  return ProductStateNotifier(repository: repo);
});

// 페이지네이션을 위한 상속

class ProductStateNotifier
    extends PaginationProvider<ProductModel, ProductRepository> {
  ProductStateNotifier({
    required super.repository,
  });
}
