import 'package:flutter/material.dart';
import 'package:video_call_study/screen/home_screen.dart';

void main() {
  runApp(
      MaterialApp(
        theme: ThemeData(
          fontFamily: 'NotoSans',
        ),
        home: HomeScreen(),
      )
  );
}
