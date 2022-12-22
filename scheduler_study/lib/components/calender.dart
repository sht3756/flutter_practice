import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatefulWidget {
  const Calender({Key? key}) : super(key: key);

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      // 헤더 스타일
      headerStyle: HeaderStyle(
        // 2주씩 보이게 하는 버튼
        formatButtonVisible: false,
        // 제목 가운데로
        titleCentered: true,
        // 제목 텍스트 스타일
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
        ),
      ),
      // 특정날짜를 선택할때 실행!
      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        print('selectedDay : $selectedDay');
        setState(() {
          this.selectedDay = selectedDay;
        });
      },
      // 특정 날짜가 선택된 지정날짜로 지정 되어야하는지 함수를 넣어주고 bool 값으로 return
      selectedDayPredicate: (DateTime date) {
        if (selectedDay == null) {
          return false;
        }

        return date.year == selectedDay!.year &&
            date.month == selectedDay!.month &&
            date.day == selectedDay!.day;
      },
    );
  }
}
