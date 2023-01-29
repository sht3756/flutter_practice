import 'package:authentication_study/common/const/colors.dart';
import 'package:authentication_study/common/layout/default_layout.dart';
import 'package:authentication_study/order/view/order_screen.dart';
import 'package:authentication_study/product/view/product_screen.dart';
import 'package:authentication_study/restaurant/view/restaurant_screen.dart';
import 'package:authentication_study/user/view/profile_screen.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  static String get routeName => 'home';

  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;

  int index = 0;

  @override
  void initState() {
    super.initState();
    // vsync 에 this 라는 현재 클래스를 넣어줘야한다. SingleTickerProviderStateMixin 를 with 해준다.
    controller = TabController(length: 4, vsync: this);

    // addListener : controller 에서 값이 변경될때 마다 특정 변수를 실행해라!
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);

    super.dispose();
  }

  // 탭 인덱스를 읽는 함수
  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '딜리버리',
      child: TabBarView(
        // TabBarView 단

        // 스크롤 안되게!
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          RestaurantScreen(),
          ProductScreen(),
          OrderScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // bottomNavigationBar 단
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: controller.index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood_outlined), label: '음식'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined), label: '주문'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: '프로필')
        ],
      ),
    );
  }
}
