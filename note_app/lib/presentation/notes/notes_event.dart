import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note_app/domain/model/note.dart';

part 'notes_event.freezed.dart';

@freezed
abstract class NotesEvent with _$NotesEvent {
  // 데이터 불러오기
  const factory NotesEvent.loadNotes() = LoadNotes;
  // 노트 삭제
  const factory NotesEvent.deleteNote(Note note) = DeleteNote;
  // 노트 다시 살리기
  const factory NotesEvent.restoreNote() = RestoreNote;
}
