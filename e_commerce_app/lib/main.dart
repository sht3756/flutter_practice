import 'package:flutter/material.dart';

import 'core/theme/theme_data.dart';
import 'data/mock/display/display_mock_api.dart';
import 'presentation/routes/routes.dart';

void main() async {
  final data = await DisplayMockApi().getMenuByMallType('market');
  print(data);
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
