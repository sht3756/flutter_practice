import 'dart:math';

import 'package:image_saerch/data/data_source/result.dart';
import 'package:image_saerch/domain/model/photo_model.dart';
import 'package:image_saerch/domain/repository/photo_api_repository.dart';

class GetPhotosUseCase {
  final PhotoApiRepository repository;

  GetPhotosUseCase(this.repository);

  // call() 로 하면 메소드 생략 가능
  Future<Result<List<PhotoModel>>> call(String query) async {
    final result = await repository.fetch(query);

    return result.when(success: (photos) {
      return Result.success(photos.sublist(0, min(3, photos.length)));
    }, error: (message) {
      return Result.error(message);
    });
  }
}
