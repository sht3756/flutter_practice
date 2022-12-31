import 'package:dusty_study/component/category_card.dart';
import 'package:dusty_study/component/hourly_card.dart';
import 'package:dusty_study/component/main_app_bar.dart';
import 'package:dusty_study/component/main_drawer.dart';
import 'package:dusty_study/constant/colors.dart';
import 'package:dusty_study/constant/regions.dart';
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
  Future<Map<ItemCode, List<StatModel>>> fetchData() async {
    Map<ItemCode, List<StatModel>> stats = {};

    for (ItemCode itemCode in ItemCode.values) {
      final statModels = await StatRepository.fetchData(
        itemCode: itemCode,
      );

      stats.addAll({
        itemCode: statModels,
      });
    }

    return stats;
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
      body: FutureBuilder<Map<ItemCode, List<StatModel>>>(
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

            Map<ItemCode, List<StatModel>> stats = snapshot.data!;
            StatModel pm10RecentStat = stats[ItemCode.PM10]![0];

            // 현재 상태
            final status = DataUtils.getStatusFromItemCodeAndValue(
                value: pm10RecentStat.seoul, itemCode: ItemCode.PM10);

            print(pm10RecentStat.seoul);

            return CustomScrollView(
              slivers: [
                MainAppBar(
                  stat: pm10RecentStat,
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
