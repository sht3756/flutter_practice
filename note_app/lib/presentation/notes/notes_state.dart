import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/domain/util/note_order.dart';

part 'notes_state.freezed.dart';

// freezed - Default([]) 로 값 넣기
// NotesViewModel 의 상태값 한번에 모아서 관리하기!
@freezed
class NotesState with _$NotesState {
  factory NotesState({
    required List<Note> notes,
    required NoteOrder noteOrder,
    required bool isOrderSectionVisible,
  }) = _NotesState;
}
