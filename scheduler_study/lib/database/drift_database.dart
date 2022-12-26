import 'dart:io';

import 'package:drift/drift.dart';
import 'package:scheduler_study/model/category_color.dart';
import 'package:scheduler_study/model/schedule.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:drift/native.dart';

// part 는 import 보다 조금 더 넓은 기능을 한다.
// import 는 private 를 불러올 수 없다.
part 'drift_database.g.dart';

@DriftDatabase(
  tables: [
    Schedules,
    CategoryColors,
  ],
)
//  _$LocalDatabase 는 현재 이 클래스에서 선언해놓지 않았다. 하지만 사용가능한 이유는 part 로 불러왔기 떄문이다.
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  // 스케쥴 추가 insert 문
  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  // 색상 추가 insert 문
  Future<int> createCategoryColor(CategoryColorsCompanion data) =>
      into(categoryColors).insert(data);

  // 카테고리 컬러 다 불러오는 select 문
  Future<List<CategoryColor>> getCategoryColors() =>
      select(categoryColors).get();

  // update 될때마다 계속 지속적으로 받는 Stream
  Stream<List<Schedule>> watchSchedules(DateTime date) {
    // .. : ..where() 함수가 실행이 되는데, 실행되는 대상이 주체(select(schedules)) 가 된다.
    return (select(schedules)..where((tbl) => tbl.date.equals(date))).watch();
  }

  // 데이터 베이스 상태의 버전이다. 데이터 구조가 변경될 떄 올려주면 된다.
  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // getApplicationDocumentsDirectory : 앱을 설치하게 되면, os 에서 앱별로 각각 사용가능한 부분에 지정을 자동으로 해준다. 그것을 가져오는 함수!
    final dbFolder = await getApplicationDocumentsDirectory();
    // dbFolder 의 경로에 내가 원하는 이름으로 파일을 저장한다.
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase(file);
  });
}
