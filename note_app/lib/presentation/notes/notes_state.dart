import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note_app/domain/model/note.dart';

part 'notes_state.freezed.dart';

part 'notes_state.g.dart';

// freezed - Default([]) 로 값 넣기
// NotesViewModel 의 상태값 한번에 모아서 관리하기!
@freezed
class NotesState with _$NotesState {
  factory NotesState({
    @Default([]) List<Note> notes,
  }) = _NotesState;

  factory NotesState.fromJson(Map<String, dynamic> json) =>
      _$NotesStateFromJson(json);
}
