import 'package:dusty_study/component/category_card.dart';
import 'package:dusty_study/component/hourly_card.dart';
import 'package:dusty_study/component/main_app_bar.dart';
import 'package:dusty_study/component/main_drawer.dart';
import 'package:dusty_study/constant/regions.dart';
import 'package:dusty_study/model/stat_and_status_model.dart';
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
  bool isExpanded = true;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Future<Map<ItemCode, List<StatModel>>> fetchData() async {
    Map<ItemCode, List<StatModel>> stats = {};

    List<Future> futures = [];

    for (ItemCode itemCode in ItemCode.values) {
      futures.add(
        StatRepository.fetchData(itemCode: itemCode),
      );
    }

    final results = await Future.wait(futures);

    for (int i = 0; i < results.length; i++) {
      final key = ItemCode.values[i];
      final value = results[i];

      stats.addAll({
        key: value,
      });
    }

    return stats;
  }

  // 스크롤 위치 읽는 함수
  scrollListener() {
    bool isExpanded = scrollController.offset < 500 - kToolbarHeight;

    if (isExpanded != this.isExpanded) {
      setState(() {
        this.isExpanded = isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<ItemCode, List<StatModel>>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // 에러일때!
            return Scaffold(body: Center(child: Text('에러가 있습니다.')));
          }

          if (!snapshot.hasData) {
            // 데이터가 없을때!
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          Map<ItemCode, List<StatModel>> stats = snapshot.data!;
          StatModel pm10RecentStat = stats[ItemCode.PM10]![0];

          // 미세먼지 최근 데이터의 현재 상태
          final status = DataUtils.getStatusFromItemCodeAndValue(
              value: pm10RecentStat.seoul, itemCode: ItemCode.PM10);

          // 키들 가져와서 매핑
          final ssModel = stats.keys.map((key) {
            final value = stats[key]!;
            final stat = value[0];

            return StatAndStatusModel(
              itemCode: key,
              status: DataUtils.getStatusFromItemCodeAndValue(
                value: stat.getLevelFromRegion(region),
                itemCode: key,
              ),
              stat: stat,
            );
          }).toList();

          return Scaffold(
            drawer: MainDrawer(
              onRegionTap: (String region) {
                setState(() {
                  this.region = region;
                });
                Navigator.of(context).pop();
              },
              selectedWidget: region,
              darkColor: status.darkColor,
              lightColor: status.lightColor,
            ),
            body: Container(
              color: status.primaryColor,
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  MainAppBar(
                    stat: pm10RecentStat,
                    status: status,
                    region: region,
                    dateTime: pm10RecentStat.dataTime,
                    isExpanded: isExpanded,
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CategoryCard(
                          region: region,
                          models: ssModel,
                          darkColor: status.darkColor,
                          lightColor: status.lightColor,
                        ),
                        const SizedBox(height: 16.0),
                        ...stats.keys.map((itemCode) {
                          final stat = stats[itemCode]!;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: HourlyCard(
                              darkColor: status.darkColor,
                              lightColor: status.lightColor,
                              category: DataUtils.getItemCodeKrString(
                                  itemCode: itemCode),
                              stats: stat,
                              region: region,
                            ),
                          );
                        }).toList(),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
