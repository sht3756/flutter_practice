import 'package:image_saerch/data/data_source/result.dart';
import 'package:image_saerch/domain/model/photo_model.dart';

abstract class PhotoApiRepository {
  Future<Result<List<PhotoModel>>> fetch(String query);
}
