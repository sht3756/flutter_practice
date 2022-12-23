import 'package:flutter/material.dart';
import 'package:scheduler_study/components/calender.dart';
import 'package:scheduler_study/components/schedule_card.dart';
import 'package:scheduler_study/components/today_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              scheduleCount: 3,
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 8.0);
                    },
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return ScheduleCard(
                          startTime: 8,
                          endTime: 9,
                          content: '기상',
                          color: Colors.red);
                    },
                  )),
            )
          ],
        ),
      ),
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
