import 'package:authentication_study/common/model/cursor_pagination_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantRatingStateNotifier
    extends StateNotifier<CursorPaginationBase> {
  RestaurantRatingStateNotifier()
      : super(
          CursorPaginationLoading(),
        );
}
