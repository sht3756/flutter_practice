import 'package:flutter/material.dart';

class SliverFillViewportExample extends StatelessWidget {
  const SliverFillViewportExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SliverFillViewport'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillViewport(
            viewportFraction: 0.5,
            delegate: SliverChildBuilderDelegate(
              childCount: 10,
              (context, index) => Container(
                color: Colors.purple[100 * (index % 9)],
                child: Text(
                  'Item $index',
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
