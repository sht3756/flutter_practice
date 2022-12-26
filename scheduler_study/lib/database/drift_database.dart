import 'dart:io';

import 'package:drift/drift.dart';
import 'package:scheduler_study/model/category_color.dart';
import 'package:scheduler_study/model/schedule.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:drift/native.dart';
import 'package:scheduler_study/model/schedule_with_color.dart';

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
  Stream<List<ScheduleWithColor>> watchSchedules(DateTime date) {
    // .. : ..where() 함수가 실행이 되는데, 실행되는 대상이 주체(select(schedules)) 가 된다.
    // return (select(schedules)..where((tbl) => tbl.date.equals(date))).watch();

    final query = select(schedules).join([
      // innerJoin(join 할 테이블, 조건)
      // join 할때는 equalsExp 를 사용
      // schedules 와 categoryColors 조인하는 데 categoryColors.id 와 schedules.colorId 같은 것만!
      innerJoin(categoryColors, categoryColors.id.equalsExp(schedules.colorId))
    ]);

    // 테이블이 두 개이기 때문에 schedules 라고 테이블 정의 해준다.
    query.where(schedules.date.equals(date));

    // 정렬
    query.orderBy([
      // asc -> 오름 차순
      // desc -> descending 내림차순
      OrderingTerm.asc(schedules.startTime),
    ]);

    // rows : 필터링된 모든 데이터들, row : 각각의 데이터 를 ScheduleWithColor 에 넣어준거다.
    // readeTable(테이블) : 해당하는 테이블 읽어와라
    return query.watch().map((rows) => rows
        .map((row) => ScheduleWithColor(
            schedule: row.readTable(schedules),
            categoryColor: row.readTable(categoryColors)))
        .toList());
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
