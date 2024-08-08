import 'dart:convert';

import '../../data_source/remote/display.api.dart';
import '../../dto/common/response_wrapper/response_wrapper.dart';
import '../../dto/display/menu/menu_dto.dart';
import 'display_mock_data.dart';

class DisplayMockApi implements DisplayApi {
  @override
  Future<ResponseWrapper<List<MenuDto>>> getMenuByMallType(String mallType) {
    return Future(
      () => ResponseWrapper(
        status: 'SUCCESS',
        code: '200',
        message: '',
        data: _menuParser(
          mallType == 'market'
              ? DisplayMockData.menusByMarket
              : DisplayMockData.menusByBeauty,
        ),
      ),
    );
  }

  List<MenuDto> _menuParser(String source) {
    List<MenuDto> menus = [];
    final List json = jsonDecode(source);
    menus = json.map((e) => MenuDto.fromJson(e)).toList();

    return menus;
  }
}
