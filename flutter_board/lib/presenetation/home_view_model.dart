import 'package:flutter/material.dart';
import 'package:flutter_board/domain/repository/board_repository.dart';
import 'package:flutter_board/presenetation/home_event.dart';
import 'package:flutter_board/presenetation/home_state.dart';

class HomeViewModel with ChangeNotifier {
  final BoardRepository _repository;

  var _state = HomeState();

  HomeState get state => _state;

  HomeViewModel(this._repository) {
    _getPost();
  }

  void onEvent(HomeEvent event) {
    event.when(
      query: _getPost,
      insert: _insert,
      update: _update,
      delete: _delete,
    );
  }

  Future _delete(int id) async {
    await _repository.delete(id);
    await _getPost();
  }

  Future _update(int id, String content) async {
    await _repository.update(id, content);
    await _getPost();
  }

  Future _insert(String content) async {
    await _repository.add(content);
    await _getPost();
  }

  Future _getPost() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _repository.getPosts()
      ..sort((a, b) => -a.id.compareTo(b.id));

    _state = state.copyWith(
      isLoading: false,
      posts: result,
    );
    notifyListeners();
  }
}
