import 'package:flutter/material.dart';

import 'author_card.dart';
import 'circle_image.dart';

class Card2 extends StatelessWidget {
  const Card2({Key? key}) : super(key: key);

  final String name = 'Mike Katz';
  final String subName = 'Smoothie Connoisseur';
  final String a = 'Smoothies';
  final String s = 'sdasd';

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
              image: AssetImage('assets/mag5.png'),
              fit: BoxFit.cover,
            )),
        child: Column(
          children: [
            AuthorCard(
              authorName: 'Mike Katz',
              title: 'Smootie',
              imageProvider: AssetImage('assets/author_katz.jpeg'),
            ),
            Row(
              children: [Text(name), Text(subName)],
            ),
          ],
        ),
      ),
    );
  }
}
