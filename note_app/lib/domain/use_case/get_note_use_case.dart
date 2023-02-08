import 'package:note_app/domain/model/note.dart';
import 'package:note_app/domain/repository/note_repository.dart';

// 고유 id 값에 해당하는 노트 가져오기
class GetNoteUseCase {
  final NoteRepository repository;
  GetNoteUseCase(this.repository);

  Future<Note?> call(int id) async {
    return await repository.getNoteById(id);
  }
}