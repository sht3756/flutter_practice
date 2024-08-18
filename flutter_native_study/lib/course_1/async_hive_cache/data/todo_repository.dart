import 'dart:async';

import 'package:flutter_native_study/course_1/async_hive_cache/api/api_service.dart';
import 'package:flutter_native_study/course_1/async_hive_cache/model/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoRepository {
  final ApiService _apiService;
  final Box<ToDo> _todoBox;
  final _toDosController = StreamController<List<ToDo>>();

  ToDoRepository(this._apiService, this._todoBox) {
    initialize();
  }

  // streamcontroller 가 외부에서 접근 못하게 get 메소드 생성
  Stream<List<ToDo>> get toDosStream => _toDosController.stream;

  void initialize() async {
    // 기존 캐시된 데이터를 방출
    _emitCachedData();

    // 새로운 데이터를 가져오고 스트림 업데이트
    await _fetchAndCacheToDos();
  }

  void _emitCachedData() {
    final cachedToDos = _todoBox.values.toList();
    _toDosController.add(cachedToDos);
  }

  Future<void> _fetchAndCacheToDos() async {
    try {
      final toDos = await _apiService.getToDos();

      for (var toDo in toDos) {
        _todoBox.put(toDo.id, toDo);
      }
      _emitCachedData();
    } catch (e) {
      print('Error fetching ToDos: $e');
    }
  }

  // 투두 등록
  Future<void> createToDo(String text) async {
    try {
      final newToDo = await _apiService.createToDos(ToDo(id: '', text: text));
      await _todoBox.put(newToDo.id, newToDo);
      _emitCachedData();
    } catch (e) {
      print('Error creating ToDo : $e');
    }
  }

  //  투두 상태 변경
  Future<void> updateToDo(String id) async {
    try {
      final updatedToDo = await _apiService.updateToDos(id);
      await _todoBox.put(id, updatedToDo);
      _emitCachedData();
    } catch (e) {
      print('Error updating ToDo : $e');
    }
  }

  // 리스트 새로고침
  Future<void> refreshToDos() async {
    await _fetchAndCacheToDos();
  }

  void dispose() {
    _toDosController.close();
  }
}
