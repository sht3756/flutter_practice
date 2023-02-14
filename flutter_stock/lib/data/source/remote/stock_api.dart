import 'package:http/http.dart' as http;

class StockApi {
  static const baseUrl = 'https://www.alphavantage.co/';
  static const apiKey = '0BC3F8Y6HH3J8OPZ';

  final http.Client client;

  StockApi({required this.client});

  Future<http.Response> getListings({String apiKey = apiKey}) async {
    return await client.get(Uri.parse(
        'https://www.alphavantage.co/query?function=LISTING_STATUS&apikey=$apiKey'));
  }
}
