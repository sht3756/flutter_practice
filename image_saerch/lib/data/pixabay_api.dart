import 'dart:convert';

import 'package:image_saerch/data/photo_api_repository.dart';
import 'package:image_saerch/model/photo_model.dart';
import 'package:http/http.dart' as http;

class PixabayApi implements PhotoApiRepository{
  static const baseUrl = 'https://pixabay.com/api/';
  static const key = '33231274-294c2e9b82f250dc8b6ae5e26';

  @override
  Future<List<PhotoModel>> fetch(String query, {http.Client? client}) async {
    // client 가 null 일때 http.Client() 로 초기화하겠다.
    client ??= http.Client();

    // http 기본 client 사용 하고 client.get 을 하면 지정한 client 있으면 사용하고 아니면 기본 client 로
    final res = await client.get(Uri.parse(
        '$baseUrl?key=$key&q=$query&image_type=photo&pretty=true'));

    Map<String, dynamic> jsonResponse = jsonDecode(res.body);

    Iterable hits = jsonResponse['hits'];
    return hits.map((e) => PhotoModel.fromJson(e)).toList();
  }
}
