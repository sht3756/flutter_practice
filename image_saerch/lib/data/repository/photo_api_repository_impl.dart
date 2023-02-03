import 'package:image_saerch/data/data_source/pixabay_api.dart';
import 'package:image_saerch/data/data_source/result.dart';
import 'package:image_saerch/domain/repository/photo_api_repository.dart';
import 'package:image_saerch/domain/model/photo_model.dart';

class PhotoApiRepositoryImpl implements PhotoApiRepository {
  PixabayApi api;

  PhotoApiRepositoryImpl(this.api);

  @override
  Future<Result<List<PhotoModel>>> fetch(String query) async {
    final Result<Iterable> result = await api.fetch(query);

    // freezed 를 사용했기떄문에, when() 함수 사용가능, 성공시 실패시 타입 분기처리
    return result.when(success: (iterable) {
      return Result.success(
          iterable.map((e) => PhotoModel.fromJson(e)).toList());
    }, error: (message) {
      return Result.error(message);
    });
  }
}
