import 'dart:async';

import 'package:image_saerch/data/photo_api_repository.dart';
import 'package:image_saerch/model/photo_model.dart';

class HomeViewModel {
  final PhotoApiRepository repository;

  HomeViewModel(this.repository);

  final _photoSteamController = StreamController<List<PhotoModel>>()..add([]);

  Stream<List<PhotoModel>> get photoStream => _photoSteamController.stream;

  Future<void> fetch(String query) async {
    final result = await repository.fetch(query);
    _photoSteamController.add(result);
  }
}
