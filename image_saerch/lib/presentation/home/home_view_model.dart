import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:image_saerch/data/data_source/result.dart';
import 'package:image_saerch/domain/repository/photo_api_repository.dart';
import 'package:image_saerch/domain/model/photo_model.dart';
import 'package:image_saerch/presentation/home/home_ui_event.dart';

// ChangeNotifier 을 mixin 하기 위함
class HomeViewModel with ChangeNotifier {
  final PhotoApiRepository repository;

  List<PhotoModel> _photos = [];

  // get 만든 이유 : 내부에서는 변경할수 있게 하고 외부에서는 불가능하게 하려고!
  // 외부에서 _photos 를 조회할 수 있게 한것이다.
  UnmodifiableListView<PhotoModel> get photos => UnmodifiableListView(_photos);

  // 이벤트를 처리하는 stream
  final _eventController = StreamController<HomeUiEvent>();

  Stream<HomeUiEvent> get eventStream => _eventController.stream;

  HomeViewModel(this.repository);

  Future<void> fetch(String query) async {
    final Result<List<PhotoModel>> result = await repository.fetch(query);
    result.when(
        success: (photos) {
          _photos = photos;
        },
        error: (message) {
          _eventController.add(HomeUiEvent.showSnackBar(message));
        });

    // 감시하고 있는 곳에 화면이 다시 그려질수 있게 알려준다.
    notifyListeners();
  }
}
