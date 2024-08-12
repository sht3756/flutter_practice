import 'package:flutter/material.dart';

class SliverGridCountExample extends StatelessWidget {
  const SliverGridCountExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SliverGrid.count'),),
      body: CustomScrollView(
        slivers: [
          SliverGrid.count(
            crossAxisCount: 4,
            children: List.generate(20, (index)=> Container(alignment: Alignment.center,
              color: Colors.green[100 * (index % 9)],
              child: Text('sliverGrid.count $index'),
            )),
          ),
        ],
      ),
    );

  }
}
