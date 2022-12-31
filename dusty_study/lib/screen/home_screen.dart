import 'package:dio/dio.dart';
import 'package:dusty_study/component/card_title.dart';
import 'package:dusty_study/component/category_card.dart';
import 'package:dusty_study/component/hourly_card.dart';
import 'package:dusty_study/component/main_app_bar.dart';
import 'package:dusty_study/component/main_card.dart';
import 'package:dusty_study/component/main_drawer.dart';
import 'package:dusty_study/component/main_stat.dart';
import 'package:dusty_study/constant/colors.dart';
import 'package:dusty_study/constant/data.dart';
import 'package:dusty_study/constant/regions.dart';
import 'package:dusty_study/constant/status_level.dart';
import 'package:dusty_study/model/stat_model.dart';
import 'package:dusty_study/repository/stat_repository.dart';
import 'package:dusty_study/utils/data_utils.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 지역
  String region = regions[0];

  @override
  Future<List<StatModel>> fetchData() async {
    final statModels = await StatRepository.fetchData();

    return statModels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: MainDrawer(
        onRegionTap: (String region) {
          setState(() {
            this.region = region;
          });
          Navigator.of(context).pop();
        },
        selectedWidget: region,
      ),
      body: FutureBuilder<List<StatModel>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              // 에러일때!
              return Center(child: Text('에러가 있습니다.'));
            }

            if (!snapshot.hasData) {
              // 데이터가 없을때!
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<StatModel> stats = snapshot.data!;
            StatModel recentStat = stats[0];

            // 현재 상태
            final status = DataUtils.getStatusFromItemCodeAndValue(
                value: recentStat.seoul, itemCode: ItemCode.PM10);

            print(recentStat.seoul);

            return CustomScrollView(
              slivers: [
                MainAppBar(
                  stat: recentStat,
                  status: status,
                  region: region,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CategoryCard(),
                      const SizedBox(height: 16.0),
                      HourlyCard(),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
