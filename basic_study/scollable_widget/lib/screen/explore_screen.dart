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
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final todayRecipes = snapshot.data?.todayRecipes ?? [];

            return ListView(
              children: [
                TodayRecipeListView(recipes: todayRecipes),
                const SizedBox(height: 32),
                FriendPostListView(),
              ],
            );
          }
          return const Text('Please add som data!!');
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
