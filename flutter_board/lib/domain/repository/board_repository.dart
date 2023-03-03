import '../model/post.dart';

abstract class BoardRepository {
  Future<List<Post>> getPosts();

  Future add(String content);

  Future update(int id, String content);

  Future delete(int id);
}