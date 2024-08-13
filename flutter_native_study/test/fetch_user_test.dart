import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
void main() {
  test('', () async {
    await fetchUsers();
  },skip: false);
}

Future<void> fetchUsers() async {
  final res =
  await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  if (res.statusCode == 200) {
    print(json.decode(res.body));
  } else {
    throw Exception('데이터를 불러오는데 실패했습니다.');
  }
}