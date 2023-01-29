import 'package:authentication_study/order/model/order_model.dart';
import 'package:authentication_study/order/model/post_order_body.dart';
import 'package:authentication_study/order/repository/order_repository.dart';
import 'package:authentication_study/user/provider/basket_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final orderProvider =
    StateNotifierProvider<OrderStateProvider, List<OrderModel>>(
  (ref) {
    final repo = ref.watch(orderRepositoryProvider);

    return OrderStateProvider(ref: ref, repository: repo);
  },
);

class OrderStateProvider extends StateNotifier<List<OrderModel>> {
  final Ref ref;
  final OrderRepository repository;

  OrderStateProvider({
    required this.ref,
    required this.repository,
  }) : super([]);

  Future<bool> postOrder() async {
    try {
      // flutter uuid
      final uuid = Uuid();
      final id = uuid.v4();

      final state = ref.read(basketProvider);

      final res = await repository.postOrder(
          body: PostOrderBody(
              id: id,
              products: state
                  .map((e) => PostOrderBodyProduct(
                      productId: e.product.id, count: e.count))
                  .toList(),
              totalPrice: state.fold(
                0,
                (p, n) => p + (n.count * n.product.price),
              ),
              createdAt: DateTime.now().toString()));
      return true;
    } catch (e) {
      return false;
    }
  }
}
