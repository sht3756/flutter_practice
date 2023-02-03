import 'package:image_saerch/domain/model/photo_model.dart';

abstract class PhotoApiRepository {
  Future<List<PhotoModel>> fetch(String query);
}
