import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'completion.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://api.openai.com/v1')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('/chat/completions')
  Future<CompletionResponse> getCompletion(@Body() CompletionRequest request);
}