import 'dart:convert';

import 'package:flutter_board/data/source/remote/board_api.dart';
import 'package:flutter_board/domain/model/post.dart';
import 'package:flutter_board/domain/repository/board_repository.dart';

class BoardRepositoryImpl implements BoardRepository {
  BoardApi api;
  BoardRepositoryImpl(this.api);

  @override
  Future add(String content) async {
  await api.insert(content);
  }

  @override
  Future delete(int id) async{
    await api.delete(id);
  }

  @override
  Future<List<Post>> getPosts() async{
    final res = await api.query();
    final Iterable json = jsonDecode(res.body);
    return json.map((e) => Post.fromJson(e)).toList();
  }

  @override
  Future update(int id, String content) async{
    await api.update(id, content);
  }
  
  
}