import 'dart:convert';

import 'package:image_saerch/model/photo_model.dart';
import 'package:http/http.dart' as http;

class PixabayApi {
  final baseUrl = 'https://pixabay.com/api/';
  final key = '33231274-294c2e9b82f250dc8b6ae5e26';

  Future<List<PhotoModel>> fetch(String query) async {
    final res = await http.post(Uri.parse(
        '$baseUrl?key=$key&q=$query&image_type=photo&pretty=true'));

    Map<String, dynamic> jsonResponse = jsonDecode(res.body);

    Iterable hits = jsonResponse['hits'];
    return hits.map((e) => PhotoModel.fromJson(e)).toList();
  }
}
