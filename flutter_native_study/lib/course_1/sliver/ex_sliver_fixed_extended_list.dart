import 'package:flutter/material.dart';

class SliverFixedExtendedListExample extends StatelessWidget {
  const SliverFixedExtendedListExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          title: const Text('SliverFixedExtendedList'),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text('List Item $index'),
              ),
            ),
            itemExtent: 50.0,
          )
        ],
      ),
    );
  }
}
