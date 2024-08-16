import 'package:flutter/material.dart';

import 'ex_inherited_widget.dart';
import 'ex_inherited_widget2.dart';

void main() {
  runApp(const MyApp());
}

final List<Map<String, dynamic>> _examples = [
  {'title': 'inheritedWidget', 'widget': const InheritedWidgetExample()},
  {'title': 'inheritedWidget2', 'widget': const InheritedWidget2Example()},
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('inherited examples'),
        ),
        body: ListView.builder(
            itemCount: _examples.length,
            itemBuilder: (context, index) {
      
          return ListTile(
            title: Text(_examples[index]['title']),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => _examples[index]['widget'],
              ),
            ),
          );
        }),
      ),
    );
  }
}
