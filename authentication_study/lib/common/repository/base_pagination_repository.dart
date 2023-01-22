import 'package:authentication_study/common/model/cursor_pagination_model.dart';
import 'package:authentication_study/common/model/model_with_id.dart';
import 'package:authentication_study/common/model/pagination_params.dart';

abstract class IBasePaginationRepository<T extends IModelWithId> {
  // paginate 함수가 타입 말고는 형태가 똑같다. 그러니 외부에서 타입을 넣어줄 수 있게 만들어주겠다.
  Future<CursorPagination<T>> paginate({
    PaginationParams? paginationParams = const PaginationParams(),
  });
}
