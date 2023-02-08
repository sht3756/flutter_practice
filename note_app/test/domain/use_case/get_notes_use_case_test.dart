import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/domain/repository/note_repository.dart';
import 'package:note_app/domain/use_case/get_notes_use_case.dart';
import 'package:note_app/domain/util/note_order.dart';
import 'package:note_app/domain/util/order_type.dart';

import 'get_notes_use_case_test.mocks.dart';

@GenerateMocks([NoteRepository])
void main() {
  test('정렬 기능 테스트!', () async {
    // Mock 클래스를 임의로 만들어준다.(기능 정의가 안되어있어서 해줘야한다.)
    final repository = MockNoteRepository();
    final getNotes = GetNotesUseCase(repository);

    // 기능정의 (가데이터로 테스트)
    when(repository.getNotes()).thenAnswer((realInvocation) async => [
          Note(title: 'title1', content: 'content1', color: 1, timestamp: 1),
          Note(title: 'title2', content: 'content2', color: 2, timestamp: 2),
        ]);

    List<Note> result = await getNotes(NoteOrder.date(OrderType.descending()));

    // 타입 테스트
    expect(result, isA<List<Note>>());

    // timestamp 테스트 : descending 을 했기 때문에, 첫번째에 timestamp 가 높은 2가 위로 올라갔다.
    expect(result.first.timestamp, 2);

    // 재 선언
    result = await getNotes(NoteOrder.date(OrderType.ascending()));
    // timestamp 테스트(ascending)
    expect(result.first.timestamp, 1);
    // 이함수를 진짜로 실행했는지 테스트
    verify(repository.getNotes());

    // 재 선언
    result = await getNotes(NoteOrder.title(OrderType.ascending()));
    // title 테스트(ascending)
    expect(result.first.title, 'title1');
    verify(repository.getNotes());

    // 재 선언
    result = await getNotes(NoteOrder.title(OrderType.descending()));
    // title 테스트(descending)
    expect(result.first.title, 'title2');
    verify(repository.getNotes());

    // 재 선언
    result = await getNotes(NoteOrder.color(OrderType.ascending()));
    // color 테스트(ascending)
    expect(result.first.color, 1);
    verify(repository.getNotes());

    // 재 선언
    result = await getNotes(NoteOrder.color(OrderType.descending()));
    // color 테스트(descending)
    expect(result.first.color, 2);
    verify(repository.getNotes());

    // 더이상 사용한것이 있냐?없으면 테스트 통과
    verifyNoMoreInteractions(repository);
  });
}
