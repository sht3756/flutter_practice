import 'package:dusty_study/constant/colors.dart';
import 'package:flutter/material.dart';

const regions = [
  '서울',
  '경기',
  '대구',
  '충남',
  '인천',
  '대전',
  '경북',
  '세종',
  '광주',
  '전북',
  '강원',
  '울산',
  '전남',
  '부산',
  '제주',
  '충북',
  '경남',
];

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: darkColor,
      child: ListView(
        children: [
          DrawerHeader(
              child: Text(
            '지역 선택',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          )),
          // 리스트가 아니고 위젯이 각각 들어가야한다. cascade operator
          ...regions
              .map((e) => ListTile(
                    // 제목 색상
                    tileColor: Colors.white,
                    // 선택된 타일 색상
                    selectedTileColor: lightColor,
                    // 선택된 글씨 색상
                    selectedColor: Colors.black,
                    // 선택된 스타일 여부
                    selected: false,
                    onTap: () {},
                    title: Text(e),
                  ))
              .toList()
        ],
      ),
    );
  }
}
