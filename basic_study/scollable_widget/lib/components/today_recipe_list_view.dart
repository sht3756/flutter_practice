import 'package:flutter/material.dart';

class TodayRecipeListView extends StatelessWidget {
  const TodayRecipeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recipes of the Day',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 16.0),
          Container(
            height: 400,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
