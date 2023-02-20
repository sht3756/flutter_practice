import 'package:flutter/material.dart';

import '../models/models.dart';

class RecipeThumbnail extends StatelessWidget {
  final SimpleRecipe recipe;
  const RecipeThumbnail({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                recipe.dishImage,
                fit: BoxFit.cover,
              )),
        ),
        const SizedBox(height: 8.0),
        Text(
          recipe.title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          '${recipe.duration} mins',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
