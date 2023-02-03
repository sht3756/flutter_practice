import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:image_saerch/data/photo_api_repository.dart';
import 'package:image_saerch/model/photo_model.dart';

// ChangeNotifier 을 mixin 하기 위함
class HomeViewModel with ChangeNotifier{
  final PhotoApiRepository repository;

  List<PhotoModel> _photos = [];

  // get 만든 이유 : 내부에서는 변경할수 있게 하고 외부에서는 불가능하게 하려고!
  // 외부에서 _photos 를 조회할 수 있게 한것이다.
  UnmodifiableListView<PhotoModel> get photos => UnmodifiableListView(_photos);

  HomeViewModel(this.repository);

  Future<void> fetch(String query) async {
    final result = await repository.fetch(query);
    _photos = result;
    // 감시하고 있는 곳에 화면이 다시 그려질수 있게 알려준다.
    notifyListeners();
  }
}
