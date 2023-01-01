import 'package:dusty_study/container/category_card.dart';
import 'package:dusty_study/container/hourly_card.dart';
import 'package:dusty_study/component/main_app_bar.dart';
import 'package:dusty_study/component/main_drawer.dart';
import 'package:dusty_study/constant/regions.dart';
import 'package:dusty_study/model/stat_model.dart';
import 'package:dusty_study/repository/stat_repository.dart';
import 'package:dusty_study/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

    fetchData();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  // 데이터 통신 후 Map 에 넣은 것들을 다 삭제 해준다. 왜냐 Hive 애 넣어서, ValueListenableBuilder 로 변경하기 위해서!
  @override
  Future<void> fetchData() async {
    final now = DateTime.now();

    // 데이터를 가져와야하는 시간의 기준
    final fetchTime = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour
    );

    // 아무 box 들고오면 된다.
    final box = Hive.box<StatModel>(ItemCode.PM10.name);
    // 가장 최근 데이터
    final recent = box.values.last as StatModel;

    // 데이터를 가져와야하는 시간과 가장 최근 데이터 의 시간이 동일하다면? 밑에있는 작업을 실행할 필요가 없다.

    print('fetchTime $fetchTime');
    print('recent $recent');
    print(recent.dataTime.isAtSameMomentAs(fetchTime));
    // isAtSameMomentAs: 같은 순간인지 파악하는 함수 같으면 true, 다르면 false
    if(recent.dataTime.isAtSameMomentAs(fetchTime)) {
        print('이미 최신 데이터가 있습니다.');
        return;
    }

    List<Future> futures = [];

    for (ItemCode itemCode in ItemCode.values) {
      futures.add(
        StatRepository.fetchData(itemCode: itemCode),
      );
    }

    final results = await Future.wait(futures);

    // Hive에 데이터 넣기
    for (int i = 0; i < results.length; i++) {
      // ItemCode
      final key = ItemCode.values[i];
      // List<StatModel>
      final value = results[i];

      final box = Hive.box<StatModel>(key.name);

      for (StatModel stat in value) {
        box.put(stat.dataTime.toString(), stat);
      }

      // 키 값 전부 가져옴
      final allKeys = box.keys.toList();

      // 24개 이상이면 삭제하는 if 문
      if(allKeys.length > 24) {
        // start - 시작 인덱스
        // end - 끝 인덱스

        // 만약 25개 라면?
        // allKeys.sublist(0, 25-24)
        final deleteKeys = allKeys.sublist(0, allKeys.length - 24);
        // 무조건 24개만 남는다.
        box.deleteAll(deleteKeys);
      }
    }
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
    return ValueListenableBuilder<Box>(
        valueListenable: Hive.box<StatModel>(ItemCode.PM10.name).listenable(),
        builder: (context, box, widget) {
          // PM10 (미세먼지)
          // box.values.toList().last

          final recentStat = box.values.toList().last as StatModel;
          // 미세먼지 최근 데이터의 현재 상태
          final status = DataUtils.getStatusFromItemCodeAndValue(
            value: recentStat.getLevelFromRegion(region),
            itemCode: ItemCode.PM10,
          );

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
                    stat: recentStat,
                    status: status,
                    region: region,
                    dateTime: recentStat.dataTime,
                    isExpanded: isExpanded,
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CategoryCard(
                          region: region,
                          darkColor: status.darkColor,
                          lightColor: status.lightColor,
                        ),
                        const SizedBox(height: 16.0),
                        ...ItemCode.values.map((itemCode) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: HourlyCard(
                              darkColor: status.darkColor,
                              lightColor: status.lightColor,
                              region: region,
                              itemCode: itemCode,
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
