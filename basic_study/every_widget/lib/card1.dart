import 'package:flutter/material.dart';

import 'fooderlich_theme.dart';

class Card1 extends StatelessWidget {
  const Card1({Key? key}) : super(key: key);

  final String category = 'Editor`s Choice';
  final String title = 'The Art of Dough';
  final String description = 'Learn to make the perfect bread';
  final String chef = 'Ray Wenderlich';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        // constraints: 한계를 준다.
        constraints: const BoxConstraints.expand(width: 350, height: 450),

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: AssetImage('assets/mag1.png'),
              fit: BoxFit.cover,
            )),
        child: Stack(
          children: [
            Text(
              category,
              style: FooderlichTheme.darkTextTheme.bodyText1,
            ),
            Positioned(
                top: 20,
                child: Text(
                  title,
                  style: FooderlichTheme.darkTextTheme.bodyText1,
                )),
            Positioned(
                bottom: 20,
                right: 0,
                child: Text(
                  description,
                  style: FooderlichTheme.darkTextTheme.bodyText1,
                )),
            Positioned(
              bottom: 0,
              right: 0,
              child: Text(
                chef,
                style: FooderlichTheme.darkTextTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
