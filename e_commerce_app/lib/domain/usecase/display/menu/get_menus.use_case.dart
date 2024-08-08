import '../../../../core/utils/error/error_response.dart';
import '../../../../presentation/pages/main/cubit/mall_type_cubit.dart';
import '../../../model/common/result.dart';
import '../../../repository/display.repository.dart';
import '../../base/remote_use_case.dart';

class GetMenusUseCse extends RemoteUseCase<DisplayRepository> {
  final MallType mallType;

  GetMenusUseCse(this.mallType);

  @override
  Future call(DisplayRepository repository) async {
    final result = await repository.getMenusByMallType(mallType: mallType);

    return (result.status == 'SUCCESS')
        ? Result.success(result.data ?? [])
        : Result.error(ErrorResponse(
            status: result.status,
            code: result.code,
            message: result.message,
          ));
  }
}
