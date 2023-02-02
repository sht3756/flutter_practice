import 'dart:async';

import 'package:image_saerch/data/api.dart';
import 'package:image_saerch/model/photo_model.dart';

class HomeViewModel {
  final PixabayApi api;

  HomeViewModel(this.api);

  final _photoSteamController = StreamController<List<PhotoModel>>()..add([]);

  Stream<List<PhotoModel>> get photoStream => _photoSteamController.stream;

  Future<void> fetch(String query) async {
    final result = await api.fetch(query);
    _photoSteamController.add(result);
  }
}
