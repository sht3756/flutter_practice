import 'package:flutter/material.dart';

class SliverToBoxAdapterExample extends StatelessWidget {
  const SliverToBoxAdapterExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 150.0,
              color: Colors.amber,
              alignment: Alignment.center,
              child: const Text('SliverToBoxAdapter'),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: 50,
                (context, index) => ListTile(
                      title: Text('List item $index'),
                    )),
          )
        ],
      ),
    );
  }
}
