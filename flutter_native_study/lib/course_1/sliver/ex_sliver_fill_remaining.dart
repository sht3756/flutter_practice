import 'package:flutter/material.dart';

class SliverFillRemainingExample extends StatelessWidget {
  const SliverFillRemainingExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SliverFillRemaining'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              alignment: Alignment.center,
              height: 150.0,
              color: Colors.amber,
              child: const Text('SliverToAdapter at Top'),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              color: Colors.red,
              alignment: Alignment.center,
              child: const Text('Fill Remaining Space'),
            ),
          )
        ],
      ),
    );
  }
}
