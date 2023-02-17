import 'package:flutter/material.dart';

import 'fooderlich_theme.dart';

class Card3 extends StatelessWidget {
  const Card3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // constraints: 한계를 준다.
        constraints: const BoxConstraints.expand(width: 350, height: 450),

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: AssetImage('assets/mag2.png'),
              fit: BoxFit.cover,
            )),
        // 스택으로 그 위에 투명하게 씌우기
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(16)),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.book,
                    color: Colors.white,
                    size: 42,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Recipe Trend',
                    style: FooderlichTheme.darkTextTheme.headline6,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    // 정렬
                    alignment: WrapAlignment.start,
                    // 클릭들 사이 간격
                    spacing: 4,
                    // 2줄일때, 간격
                    // runSpacing: 30,
                    children: [
                      // 클립
                      Chip(
                          onDeleted: () {
                            print('삭제');
                          },
                          label: Text(
                            '건강',
                            style: FooderlichTheme.darkTextTheme.bodyText1,
                          )),
                      Chip(
                          label: Text(
                            'Vegan',
                            style: FooderlichTheme.darkTextTheme.bodyText1,
                          )),
                      Chip(
                          label: Text(
                            '건강',
                            style: FooderlichTheme.darkTextTheme.bodyText1,
                          )),
                      Chip(
                          label: Text(
                            '건강',
                            style: FooderlichTheme.darkTextTheme.bodyText1,
                          )),
                      Chip(
                          label: Text(
                            '건강',
                            style: FooderlichTheme.darkTextTheme.bodyText1,
                          )),
                      Chip(
                          label: Text(
                            '건강',
                            style: FooderlichTheme.darkTextTheme.bodyText1,
                          )),
                      Chip(
                          label: Text(
                            '건강',
                            style: FooderlichTheme.darkTextTheme.bodyText1,
                          )),
                    ],
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
