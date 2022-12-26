import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:scheduler_study/components/calender.dart';
import 'package:scheduler_study/components/new_schedule_bottom_sheet.dart';
import 'package:scheduler_study/components/schedule_card.dart';
import 'package:scheduler_study/components/today_banner.dart';
import 'package:scheduler_study/constant/colors.dart';
import 'package:scheduler_study/database/drift_database.dart';
import 'package:scheduler_study/model/schedule_with_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // utc 기준으로 DateTime 넣기
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: renderFloatingActionButton(),
      body: SafeArea(
        child: Column(
          children: [
            Calender(
              selectedDay: selectedDay,
              focusedDay: focusedDay,
              onDaySelected: onDaySelected,
            ),
            SizedBox(height: 8.0),
            TodayBanner(
              selectedDay: selectedDay,
            ),
            SizedBox(height: 8.0),
            _ScheduleList(selectedDate: selectedDay),
          ],
        ),
      ),
    );
  }

  // 플로팅 버튼
  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (_) {
              return ScheduleBottomSheet(
                selectedDate: selectedDay,
              );
            });
      },
      backgroundColor: PRIMARY_COLOR,
      child: Icon(Icons.add),
    );
  }

  onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    print('selectedDay : $selectedDay');
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }
}

class _ScheduleList extends StatelessWidget {
  final DateTime selectedDate;

  const _ScheduleList({Key? key, required this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: StreamBuilder<List<ScheduleWithColor>>(
              stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData && snapshot.data!.isEmpty) {
                  // 데이터 통신은 잘해서 data 는 잘 받아오는데, 리스트가 빈 값이라면?
                  return Center(
                    child: Text('스케줄이 없습니다.'),
                  );
                }
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 8.0);
                  },
                  itemBuilder: (context, index) {
                    // 각각의 인덴스별 스케쥴
                    final scheduleWithColor = snapshot.data![index];

                    // 스와이퍼 가능하게끔 해주는 위젯
                    return Dismissible(
                      // 어떤 위젯이 삭제가 됐는지 인식을 한다. (유니크한 키)
                      key: ObjectKey(scheduleWithColor.schedule.id),
                      // 어디로 스와이프 할지 설정
                      direction: DismissDirection.endToStart,
                      // 스와이프 됐을때 함수 설정
                      onDismissed: (DismissDirection direction){
                        GetIt.I<LocalDatabase>().removeSchedule(scheduleWithColor.schedule.id);
                      },
                      child: GestureDetector(
                        onTap: (){
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (_) {
                                return ScheduleBottomSheet(
                                  selectedDate: selectedDate,
                                  scheduleId: scheduleWithColor.schedule.id,
                                );
                              });
                        },
                        child: ScheduleCard(
                            startTime: scheduleWithColor.schedule.startTime,
                            endTime: scheduleWithColor.schedule.endTime,
                            content: scheduleWithColor.schedule.content,
                            color: Color(int.parse(
                                'FF${scheduleWithColor.categoryColor.hexCode}',
                                radix: 16))),
                      ),
                    );
                  },
                );
              })),
    );
  }
}
