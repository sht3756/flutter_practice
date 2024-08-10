import 'package:get_it/get_it.dart';

import 'data/data_source/remote/display.api.dart';
import 'data/mock/display/display_mock_api.dart';
import 'data/repository_impl/display.repository_impl.dart';

final locator = GetIt.instance;

void setLocator() {

}

void _data() {
  locator.registerSingleton<DisplayApi>(DisplayMockApi());
}

void _domain() {
  locator.registerSingleton(DisplayRepositoryImpl(locator<DisplayApi>()));
}