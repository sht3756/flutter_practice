import 'package:flutter/material.dart';
import '../components/components.dart';

import '../models/models.dart';
import '../api/mock_fooderlich_service.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({Key? key}) : super(key: key);

  final mockService = MockFooderlichService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ExploreData>(
      future: mockService.getExploreData(),
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        print(snapshot.hasData);

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final todayRecipes = snapshot.data?.todayRecipes ?? [];

            return TodayRecipeListView();
          }
          return Text('Please add som data!!');
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
