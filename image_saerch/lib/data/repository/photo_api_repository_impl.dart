import 'package:image_saerch/data/data_source/pixabay_api.dart';
import 'package:image_saerch/domain/repository/photo_api_repository.dart';
import 'package:image_saerch/domain/model/photo_model.dart';

class PhotoApiRepositoryImpl implements PhotoApiRepository {
  PixabayApi api;

  PhotoApiRepositoryImpl(this.api);

  @override
  Future<List<PhotoModel>> fetch(String query) async {
    final result = await api.fetch(query);
    return result.map((e) => PhotoModel.fromJson(e)).toList();
  }
}
