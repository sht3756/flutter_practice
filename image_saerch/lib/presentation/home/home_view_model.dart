import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:image_saerch/data/data_source/result.dart';
import 'package:image_saerch/domain/repository/photo_api_repository.dart';
import 'package:image_saerch/domain/model/photo_model.dart';
import 'package:image_saerch/presentation/home/home_state.dart';
import 'package:image_saerch/presentation/home/home_ui_event.dart';

// ChangeNotifier 을 mixin 하기 위함
class HomeViewModel with ChangeNotifier {
  final PhotoApiRepository repository;

  HomeState _state = HomeState([], false);

  HomeState get state => _state;



  // 이벤트를 처리하는 stream
  final _eventController = StreamController<HomeUiEvent>();

  Stream<HomeUiEvent> get eventStream => _eventController.stream;

  HomeViewModel(this.repository);

  Future<void> fetch(String query) async {
    _state = state.copyWith(isLoading:  true);
    // 감시하고 있는 곳에 화면이 다시 그려질수 있게 알려준다.
    notifyListeners();

    final Result<List<PhotoModel>> result = await repository.fetch(query);
    result.when(success: (photos) {
      _state = state.copyWith(photos: photos);
    }, error: (message) {
      _eventController.add(HomeUiEvent.showSnackBar(message));
    });

    _state = state.copyWith(isLoading: false);
    // 감시하고 있는 곳에 화면이 다시 그려질수 있게 알려준다.
    notifyListeners();
  }
}
