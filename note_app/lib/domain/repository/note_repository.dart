import 'package:note_app/domain/model/note.dart';

abstract class NoteRepository {
  // 노트 객체 얻는 기능
  Future<List<Note>> getNotes();

  // 클릭하면 해당 되는 노트 가져오기
  Future<Note> getNoteById(int id);

  // 등록
  Future<void> insertNote(Note note);

  // 수정
  Future<void> updateNote(Note note);

  // 삭제
  Future<void> deleteNote(Note note);
}