import 'package:flutter/material.dart';

import 'ex_future_builder_1.dart';
import 'ex_future_builder_2.dart';
import 'ex_stop_watch.dart';
import 'ex_stream_clock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'stream_future',
      home: StreamFutureApp(),
    );
  }
}


class StreamFutureApp extends StatelessWidget {
  StreamFutureApp({super.key});

  final List _list = [
    {'title': 'stream_clock', 'widget':const StreamClockScreen()},
    {'title': 'stop_watch', 'widget':const StopWatchScreen()},
    {'title': 'future_builder_1', 'widget':const FutureBuilderExample1()},
    {'title': 'future_builder_2', 'widget':const FutureBuilderExample2()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('stream & future 예제'),
      ),
      body: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(_list[index]['title'],),
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => _list[index]['widget'],),),);
        },),
    );
  }
}
