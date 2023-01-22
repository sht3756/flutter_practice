import 'package:authentication_study/common/provider/pagination_provider.dart';
import 'package:flutter/cupertino.dart';

// 공통된 페이징 스크롤 일반화
class PaginationUtils {
  static void paginate({
    required ScrollController controller,
    required PaginationProvider provider,
  }) {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      provider.paginate(
        fetchMore: true,
      );
    }
  }
}
