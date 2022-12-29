import 'package:dusty_study/component/card_title.dart';
import 'package:dusty_study/component/category_card.dart';
import 'package:dusty_study/component/main_app_bar.dart';
import 'package:dusty_study/component/main_card.dart';
import 'package:dusty_study/component/main_drawer.dart';
import 'package:dusty_study/component/main_stat.dart';
import 'package:dusty_study/constant/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: MainDrawer(),
      body: CustomScrollView(
        slivers: [
          MainAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CategoryCard(),
                const SizedBox(height: 16.0),
                MainCard(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CardTitle(
                      title: '시간별 미세먼지',
                    ),
                    Column(
                      children: List.generate(24, (index) {
                        // 현재시간
                        final now = DateTime.now();
                        // 현재 시
                        final hour = now.hour;
                        int currentHour = hour - index;

                        // 현재 시 0 보다 작으면 하루를 더한다.
                        if (currentHour < 0) {
                          currentHour += 24;
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(
                                '$currentHour시',
                              )),
                              Expanded(
                                child: Image.asset(
                                  'asset/img/good.png',
                                  height: 20.0,
                                ),
                              ),
                              Expanded(
                                  child: Text(
                                '좋음',
                                textAlign: TextAlign.right,
                              ))
                            ],
                          ),
                        );
                      }),
                    )
                  ],
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
