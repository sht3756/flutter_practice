import 'package:flutter/material.dart';

import '../models/models.dart';
import 'card1.dart';

class TodayRecipeListView extends StatelessWidget {
  final List<ExploreRecipe> recipes;

  const TodayRecipeListView({Key? key, required this.recipes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Recipes of the Day',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        SizedBox(
          height: 400,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return _buildCard(recipes[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 20.0);
            },
            itemCount: recipes.length,
          ),
        )
      ],
    );
  }

  // 카드
  Widget _buildCard(ExploreRecipe exploreRecipe) {
    if(exploreRecipe.cardType == RecipeCardType.card1) {
      return Card1(recipe: exploreRecipe);
    }else if(exploreRecipe.cardType == RecipeCardType.card2) {
      return Card1(recipe: exploreRecipe);
    }if(exploreRecipe.cardType == RecipeCardType.card3) {
      return Card1(recipe: exploreRecipe);
    }else{
      throw Exception('This card does not exist!!');
    }

  }
}
