import 'package:flutter/material.dart';

import 'core/theme/theme_data.dart';
import 'data/mock/display/display_mock_api.dart';
import 'data/repository_impl/display.repository_impl.dart';
import 'presentation/pages/main/cubit/mall_type_cubit.dart';
import 'presentation/routes/routes.dart';
import 'service_locator.dart';

void main() async {
  setLocator();
  final data = await DisplayMockApi().getMenuByMallType('market');
  final data1 = await DisplayRepositoryImpl(DisplayMockApi()).getMenusByMallType(mallType: MallType.market);
  print(data);
  print(data1);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: CustomThemeData.themeData,
    );
  }
}
