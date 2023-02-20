import 'package:flutter/material.dart';

class EmptyGroceryScreen extends StatelessWidget {
  const EmptyGroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Flexible : Column, Row 에 사용가능, 가능한 최대의 비율 차지
        // AspectRatio 비율
        Flexible(
            child: AspectRatio(
                aspectRatio: 1.0,
                child: Image.asset('assets/fooderlich_assets/empty_list.png'))),
        Text(
          'No Groceries',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8.0),
        Text(
          'SHopping for ingredients? Write them down!',
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        MaterialButton(
          onPressed: () {},
          color: Colors.green,
          height: 36,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),

          ),
          child: Text('Browse Recipes'),
        )
      ],
    );
  }
}
