import 'package:dusty_study/main.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final box = Hive.box(testBox);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TestScreen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'TestScreen',
            textAlign: TextAlign.center,
          ),
          ValueListenableBuilder<Box>(
            // streamBuilder 와 같다.
              // valueListenable: Hive.box(읽고싶은 박스).listenable()
              valueListenable: Hive.box(testBox).listenable(),
              builder: (context, box, widget) {
                // box 의 상태값이 변할 때마다 builder() 가 다시 호출한다.
                print(box.values.toList());

                return Column(
                  children: box.values.map((e) => Text(e.toString())).toList(),
                );
              }),
          ElevatedButton(
            onPressed: () {
              print('key: ${box.keys.toList()}');
              print('value: ${box.values.toList()}');
            },
            child: Text('박스 프린트하기'),
          ),
          ElevatedButton(
            onPressed: () {
              // add : box 값에 순서대로 넣는다.
              // box.add(value);
              // put : 데이터 생성하거나, 업데이트 할 때! put(key, value)
              // delete(key) : 해당 key 삭제
              // deleteAt(인덱스): 해당 index 삭제
              box.put(10, 2);
            },
            child: Text('데이터 넣기'),
          ),
          ElevatedButton(
            onPressed: () {
              // key 2 를 찾는다.
              print(box.get(2));
              // 3 번째 인덱스를 찾는다.
              print(box.getAt(3));

            },
            child: Text('데이터 값 가져오기!'),
          ),
        ],
      ),
    );
  }
}
