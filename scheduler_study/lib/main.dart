import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:scheduler_study/database/drift_database.dart';
import 'package:scheduler_study/screen/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

// 색상 배열
const  DEFAULT_COLORS = [
  // 빨강
  'F44336',
  // 주황
  'FF9800',
  // 노랑
  'FFEB3B',
  // 초록
  'FCAF50',
  // 파랑
  '2196F3',
  // 남
  '3F51B5',
  // 보라
  '9C27B0',
];

void main() async {
  // flutter 프레임 워크가 준비가 된 상태인지 확인하는 함수
  // runApp() 이 실행되기전 initializeDateFormatting() 함수를 사용하기 위해서 그 전에 프레임 워크가 준비가 되었는지 확인해줘야한다.
  WidgetsFlutterBinding.ensureInitialized();

  // intl 초기화
  await initializeDateFormatting();

  final database = LocalDatabase();

  // 디비의 카테고리색상 불러오기!
  final colors = await database.getCategoryColors();

  // 만약 DB 에서 불러온 카테고리 컬러가 없을시 실행
  if(colors.isEmpty) {
   for(String hexCode in DEFAULT_COLORS) {
     await database.createCategoryColor(
       CategoryColorsCompanion(
         hexCode: Value(hexCode),
       )
     );
   }
  }


  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'NotoSans'),
      home: HomeScreen(),
    ),
  );
}
