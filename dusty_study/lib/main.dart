import 'package:dusty_study/model/stat_model.dart';
import 'package:dusty_study/screen/home_screen.dart';
import 'package:dusty_study/screen/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

const testBox = 'test';

void main() async {
  // 플러터 초기화
  await Hive.initFlutter();

  // Hive 어댑터 등록<클래스>(해당 어댑터)!
  Hive.registerAdapter<StatModel>(StatModelAdapter());
  Hive.registerAdapter<ItemCode>(ItemCodeAdapter());

  // await Hive.openBox(testBox);

  for(ItemCode itemCode in ItemCode.values) {
    await Hive.openBox<StatModel>(itemCode.name);
  }

  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'sunflower'),
    home: HomeScreen(),
  ));
}
