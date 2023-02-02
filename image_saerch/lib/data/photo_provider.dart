import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_saerch/data/api.dart';
import 'package:image_saerch/model/photo_model.dart';

class PhotoProvider extends InheritedWidget {
  final PixabayApi api;
  final _photoSteamController = StreamController<List<PhotoModel>>()..add([]);

  Stream<List<PhotoModel>> get photoStream => _photoSteamController.stream;

  PhotoProvider({
    Key? key,
    required this.api,
    required Widget child,
  }) : super(key: key, child: child);

  static PhotoProvider of(BuildContext context) {
    final PhotoProvider? result =
        context.dependOnInheritedWidgetOfExactType<PhotoProvider>();
    assert(result != null, 'No pixabayApi found in context');
    return result!;
  }

  Future<void> fetch(String query) async {
    final result = await api.fetch(query);
    _photoSteamController.add(result);
  }
  @override
  bool updateShouldNotify(PhotoProvider oldWidget) {
    return oldWidget.api != api;
  }
}
