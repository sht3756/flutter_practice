import 'package:flutter/material.dart';

class SliverGridExtentExample extends StatelessWidget {
  const SliverGridExtentExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SliverGrid.extent'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverGrid.extent(
            maxCrossAxisExtent: 150.0,
            childAspectRatio: 2 / 3,
            children: List.generate(
              20,
              (index) => Container(
                alignment: Alignment.center,
                color: Colors.pink[100 * (index % 9)],
                child: Text('Grid Item $index'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
