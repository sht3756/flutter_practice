import 'package:flutter/material.dart';
import 'package:scheduler_study/screen/home_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  // flutter 프레임 워크가 준비가 된 상태인지 확인하는 함수
  // runApp() 이 실행되기전 initializeDateFormatting() 함수를 사용하기 위해서 그 전에 프레임 워크가 준비가 되었는지 확인해줘야한다.
  WidgetsFlutterBinding.ensureInitialized();

  // intl 초기화
  await initializeDateFormatting();

  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'NotoSans'),
      home: HomeScreen(),
    ),
  );
}
