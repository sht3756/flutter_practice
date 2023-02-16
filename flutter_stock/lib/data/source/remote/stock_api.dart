import 'dart:convert';

import 'package:flutter_stock/data/source/remote/dto/company_info_dto.dart';
import 'package:http/http.dart' as http;

class StockApi {
  static const baseUrl = 'https://www.alphavantage.co/';
  static const apiKey = '0BC3F8Y6HH3J8OPZ';

  final http.Client _client;

  StockApi({http.Client? client}) : _client = (client ?? http.Client());

  Future<http.Response> getListings({String apiKey = apiKey}) async {
    return await _client.get(
        Uri.parse('$baseUrl/query?function=LISTING_STATUS&apikey=$apiKey'));
  }

  Future<CompanyInfoDto> getCompanyInfo({
    required String symbol,
    String apiKey = apiKey,
  }) async {
    final res = await _client.get(Uri.parse(
        '$baseUrl/query?function=OVERVIEW&symbol=$symbol&apikey=$apiKey'));

    return CompanyInfoDto.fromJson(jsonDecode(res.body));
  }

  Future<http.Response> getIntradayInfo({
    required String symbol,
    String apiKey = apiKey,
  }) async {
    return await _client.get(Uri.parse(
        '$baseUrl/query?function=TIME_SERIES_INTRADAY&symbol=$symbol&interval=60min&apikey=$apiKey&datatype=csv'));
  }
}
