import 'package:dusty_study/constant/regions.dart';
import 'package:flutter/material.dart';

typedef OnRegionTap = void Function(String region);

class MainDrawer extends StatelessWidget {
  final OnRegionTap onRegionTap;

  // 선택된 지역
  final String selectedWidget;
  final Color darkColor;
  final Color lightColor;

  const MainDrawer(
      {Key? key,
      required this.onRegionTap,
      required this.selectedWidget,
      required this.darkColor,
      required this.lightColor})
      : super(key: key);

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
                    // 선택된 지역
                    selected: e == selectedWidget,
                    onTap: () {
                      onRegionTap(e);
                    },
                    title: Text(e),
                  ))
              .toList()
        ],
      ),
    );
  }
}
