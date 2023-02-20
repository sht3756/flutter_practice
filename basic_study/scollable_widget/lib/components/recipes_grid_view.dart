import 'package:flutter/material.dart';

import '../models/models.dart';
import 'recipe_thumbnail.dart';

class RecipesGridView extends StatelessWidget {
  final List<SimpleRecipe> recipes;

  const RecipesGridView({Key? key, required this.recipes}) : super(key: key);

  static const _gridPadding = 24.0;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(_gridPadding),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // 아이템 위 아래 간격
        mainAxisSpacing: _gridPadding,
        // 아이템 사이 간격
        crossAxisSpacing: _gridPadding,
      ),
      itemBuilder: (BuildContext context, int index) {
        return RecipeThumbnail(
          recipe: recipes[index],
        );
      },
      itemCount: recipes.length,
    );
  }
}
