import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../dto/common/response_wrapper/response_wrapper.dart';
import '../../dto/display/menu/menu_dto.dart';

part 'display.api.g.dart';

@RestApi()
abstract class DisplayApi {
  factory DisplayApi(Dio dio, {String baseUrl}) = _DisplayApi;

  @GET('/api/menus/{mall_type}')
  Future<ResponseWrapper<List<MenuDto>>> getMenuByMallType(@Path('mall_type') String mallType);
}