import 'package:flutter/material.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/domain/use_case/use_cases.dart';
import 'package:note_app/domain/util/note_order.dart';
import 'package:note_app/domain/util/order_type.dart';
import 'package:note_app/presentation/notes/notes_event.dart';
import 'package:note_app/presentation/notes/notes_state.dart';

class NotesViewModel with ChangeNotifier {
  final UseCases useCases;

  // default 값 설정
  NotesState _state = NotesState(
      notes: [], noteOrder: const NoteOrder.date(OrderType.descending()));

  NotesState get state => _state;

  Note? _recentlyDeletedNote;

  NotesViewModel(this.useCases) {
    _loadNotes();
  }

  void onEvent(NotesEvent event) {
    event.when(
      loadNotes: _loadNotes,
      deleteNote: _deleteNote,
      restoreNote: _restoreNote,
    );
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await useCases.getNotes(state.noteOrder);
    // 정렬(날짜 기준)
    notes.sort((a, b) => -a.timestamp.compareTo(b.timestamp));

    _state = state.copyWith(notes: notes);
    notifyListeners();
  }

  Future<void> _deleteNote(Note note) async {
    await useCases.deleteNote(note);
    // 최근 삭제 노트 담기
    _recentlyDeletedNote = note;
    // 삭제 후 다시 로드
    await _loadNotes();
  }

  Future<void> _restoreNote() async {
    // 최근 삭제 리스트가 있다면, 최근 삭제 리스트를 다시 등록 한다. 그리고 비워준다. 그리고 다시 로드
    if (_recentlyDeletedNote != null) {
      await useCases.addNote(_recentlyDeletedNote!);
      _recentlyDeletedNote = null;

      _loadNotes();
    }
  }
}
