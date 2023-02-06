import 'package:note_app/domain/model/note.dart';
import 'package:sqflite/sqflite.dart';

// sql helper 라고 한다.
class NoteDb {
  // sqflite 에서 제공하는 db 객체
  Database db;

  NoteDb(this.db);

  // id 별 note 가져오기
  Future<Note?> getNoteById(int id) async {
    // SELECT * FROM note WHERE id = 1
    final List<Map<String, dynamic>> maps = await db.query(
      'note',
      where: 'id = ?',
      whereArgs: [id],
    );

    // 조건1 : maps 가 있다면, (id 는 고유값이니 무조건 하나 나올것임.)
    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    }
    // 데이터가 없으면 null 리턴
    return null;
  }

  // 전체 note 가져오기
  Future<List<Note>> getNotes() async {
    final maps = await db.query('note');
    return maps.map((e) => Note.fromJson(e)).toList();
  }

  // 등록
  Future<void> insertNote(Note note) async {
    await db.insert('note', note.toJson());
  }

  // 수정
  Future<void> updateNote(Note note) async {
    await db.update(
      'note',
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  // 삭제
  Future<void> deleteNote(Note note) async {
    await db.delete(
      'note',
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }
}
