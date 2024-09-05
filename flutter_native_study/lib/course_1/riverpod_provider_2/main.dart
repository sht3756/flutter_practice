import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'exam_async_notifier_provider.dart';
import 'exam_change_notifier_provider.dart';
import 'exam_notifier_provider.dart';
import 'exam_stream_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Center(child: ProductListScreen()));
  }
}
