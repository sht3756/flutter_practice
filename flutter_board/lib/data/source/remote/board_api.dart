import 'package:http/http.dart' as http;

class BoardApi {
  final http.Client _client;

  // 10.0.2.2
  static const baseUrl = 'http://10.0.2.2:9001';

  BoardApi({http.Client? client}) : _client = (client ?? http.Client());

  Future<http.Response> query() async {
    return await _client.get(Uri.parse('$baseUrl/query.php'));
  }

  Future<http.Response> insert(String content) async {
    return await _client.get(Uri.parse('$baseUrl/insert.php?content=$content'));
  }

  Future<http.Response> update(int id, String content) async {
    return await _client.get(Uri.parse('$baseUrl/update.php?id=$id&content=$content'));
  }

  Future<http.Response> delete(int id) async {
    return await _client.get(Uri.parse('$baseUrl/delete.php?id=$id'));
  }
}