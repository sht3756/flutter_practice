import 'package:scheduler_study/database/drift_database.dart';

// 두개의 테이블의 대한 값을 담기 위함
class ScheduleWithColor {
  final Schedule schedule;
  final CategoryColor categoryColor;

  ScheduleWithColor({
    required this.schedule,
    required this.categoryColor,
  });
}
