import 'package:flutter_test/flutter_test.dart';
import 'package:note_app/data/data_source/note_db_helper.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  test('db test', () async {
    // db 생성
    var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);

    // db 테이블 생성
    await db.execute(
      'CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, color INTEGER, timestamp INTEGER)',
    );

    final noteDbHelper = NoteDbHelper(db);

    await noteDbHelper.insertNote(Note(
      title: 'test',
      content: 'testcontent',
      color: 1,
      timestamp: 11,
    ));

    // 검사 1
    expect((await noteDbHelper.getNotes()).length, 1);

    // id 1, note 가져오기
    Note note = (await noteDbHelper.getNoteById(1))!;
    // 검사 2
    expect(note.id, 1);

    // 이름변경
    await noteDbHelper.updateNote(note.copyWith(title: 'change'));

    // id 1, note 가져오기
    note = (await noteDbHelper.getNoteById(1))!;
    // 검사 3
    expect(note.title, 'change');

    // note 삭제
    await noteDbHelper.deleteNote(note);
    // 검사 4
    expect((await noteDbHelper.getNotes()).length, 0);

    // db 접속 종료
    await db.close();
  });
}
