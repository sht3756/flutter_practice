import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_saerch/data/data_source/result.dart';

class PixabayApi {
  final http.Client client;

  PixabayApi(this.client);

  static const baseUrl = 'https://pixabay.com/api/';
  static const key = '33231274-294c2e9b82f250dc8b6ae5e26';

  Future<Result<Iterable>> fetch(String query) async {
    try{
      final res = await client.get(
          Uri.parse('$baseUrl?key=$key&q=$query&image_type=photo&pretty=true'));
      Map<String, dynamic> jsonResponse = jsonDecode(res.body);
      Iterable hits = jsonResponse['hits'];
      return Result.success(hits);
    }catch(e){
      return const Result.error('error');

    }

  }
}
