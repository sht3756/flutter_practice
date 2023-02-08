import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/domain/util/note_order.dart';

part 'notes_event.freezed.dart';

@freezed
abstract class NotesEvent with _$NotesEvent {
  // 데이터 불러오기
  const factory NotesEvent.loadNotes() = LoadNotes;
  // 노트 삭제
  const factory NotesEvent.deleteNote(Note note) = DeleteNote;
  // 노트 다시 살리기
  const factory NotesEvent.restoreNote() = RestoreNote;
  // 정렬에 따른 변화
  const factory NotesEvent.changeOrder(NoteOrder noteOrder) = ChangeOrder;
}
