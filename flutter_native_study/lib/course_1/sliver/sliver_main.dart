import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_study/course_1/sliver/ex_sliver_app_bar.dart';

import 'sliver.dart';

void main() {
  runApp(const MyApp1());
}

class MyApp1 extends StatelessWidget {
  const MyApp1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true),
      home: const SliverExampleNavigatorList(),
    );
  }
}

final List<Map<String, dynamic>> _examples = [
  {'title': 'SliverAppBar', 'widget': const SliverAppBarExample()},
  {'title': 'SliverPersistentHeader', 'widget': const SliverPersistentHeaderExample()},
  {'title': 'SliverPadding', 'widget': const SliverPaddingExample()},
  {'title': 'SliverToBoxAdapter', 'widget': const SliverToBoxAdapterExample()},
  {'title': 'SliverGrid', 'widget': const SliverGridExample()},
  {'title': 'SliverFixedExtendedList', 'widget': const SliverFixedExtendedListExample()},
  {'title': 'SliverGrid.count', 'widget': const SliverGridCountExample()},
  {'title': 'SliverGrid.extent', 'widget': const SliverGridExtentExample()},
  {'title': 'SliverAnimatedList', 'widget': const SliverAnimatedListExample()},
  {'title': 'SliverFillRemaining', 'widget': const SliverFillRemainingExample()},
  {'title': 'SliverFillViewport', 'widget': const SliverFillViewportExample()},
];

class SliverExampleNavigatorList extends StatelessWidget {
  const SliverExampleNavigatorList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'sliver examples',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.primaries.first,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_examples[index]['title']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => _examples[index]['widget'],
                ),
              );
            },
          );
        },
        itemCount: _examples.length,
      ),
    );
  }
}
