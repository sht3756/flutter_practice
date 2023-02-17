import 'package:flutter/material.dart';

import 'author_card.dart';

class Card2 extends StatelessWidget {
  const Card2({Key? key}) : super(key: key);

  final String name = 'Smoothie';
  final String subName = 'Recipe';

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
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        name,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                  Text(
                    subName,
                    style: Theme.of(context).textTheme.headline1,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
