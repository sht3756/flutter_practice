import 'package:note_app/domain/use_case/add_note_use_case.dart';
import 'package:note_app/domain/use_case/delete_note_use_case.dart';
import 'package:note_app/domain/use_case/get_note_use_case.dart';
import 'package:note_app/domain/use_case/get_notes_use_case.dart';
import 'package:note_app/domain/use_case/update_note_use_case.dart';

// useCase 너무 많아지니깐 한번에 관리하기 위함.
class UseCases {
  final AddNoteUseCase addNote;
  final DeleteNoteUseCase deleteNote;
  final GetNotesUseCase getNotes;
  final GetNoteUseCase getNote;
  final UpdateNoteUseCase updateNote;

  UseCases({
    required this.addNote,
    required this.deleteNote,
    required this.getNotes,
    required this.getNote,
    required this.updateNote,
  });
}
