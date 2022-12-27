import 'package:flutter/material.dart';
import 'package:single_child_scroll_view_study/layout/main_layout.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  const SingleChildScrollViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        title: 'SingleChildScrollView',
        body: Container(
          child: Text('hello'),
        ));
  }
}
